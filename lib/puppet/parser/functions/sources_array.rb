module Puppet::Parser::Functions
  newfunction(:sources_array, :type => :rvalue, :doc => <<-EOS
This function creates an array of sources for the source attribute of the file resource.
It looks for the 'file_source_hierarchy' array defined in hiera or in the top scope.
It takes each element in this array and generates a complete puppet file server URI.

'puppet:///{mount_point}/{source}/{path}'

*Parameters*
  *mount point name*: The name of the mount point (Note te lack of leading or trailing slashes)
            Ex: 'modules/module_name'
              'custom_mount/${::owner}'
  *append path*: The path to be appended.
          Ex: 'example.txt'
  *default* (optional): an optional path that can be added outside the above hierachy
              Ex: 'puppet:///modules/example_module/example.txt'

*Example:*

    # /etc/puppet/manifests/site.pp
    $file_source_hierarchy = [
      $::fqdn,
      $::domain,
      'common'
    ]

    # Private files mount point
    $private_files = "modules/example_module"

    # /etc/puppet/modules/example_module/manifests/init.pp
    ...
    file { "/tmp/example.txt":
      source => sources_array(
        $::private_files,
        'example.txt',
        'puppet:///modules/example_module/example.txt'
      )
    }
    ...

Would result in:

    file { "/tmp/example.txt":
      source => [
        'puppet:///modules/example_module/test.example.com/example.txt,
        'puppet:///modules/example_module/example.com/example.txt,
        'puppet:///modules/example_module/common/example.txt,
        'puppet:///modules/example_module/example.txt
      ]
    }
    EOS
  ) do |arguments|

  # Check arguments
  raise(Puppet::ParseError, "sources(): Wrong number of arguments " +
    "given (#{arguments.size} for 2 or 3)")  unless arguments.size.between?(2, 3)

  # Arguments
  mount_point = arguments[0]
  path = arguments[1]
  default_source = arguments[2]

  # Lookup file_source_hierarchy
  sources = lookupvar('::file_source_hierarchy')

  # Create an Array object
  sources_array = Array.new

  # Push each element from the sources array
  if sources.is_a?(Array)
    sources.each do |source|
      sources_array.push "puppet:///#{mount_point}/#{source}/#{path}"
    end
  end

  # Optional default value
  if default_source
    sources_array.push default_source
  end

  # Return final array
  return sources_array

  end
end
