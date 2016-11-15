# =============================================================================
#
# MODULE      : {{filename}}
# PROJECT     : {{project_namespace}}
# DESCRIPTION :
#
# Copyright (c) {{copyright_year}}, {{copyright_owner}}.  All rights reserved.
# =============================================================================


require_relative 'lib/{{project_name}}/version.rb'

Gem::Specification.new do |spec|
  spec.name         = '{{project_name}}'
  spec.version      = {{project_namespace}}::VERSION
  spec.authors      = ["{{copyright_owner}}"]
  spec.email        = [""]
  spec.summary      = ""
  spec.description  = %q{
                      }.gsub( /\s+/, ' ').strip
  spec.homepage     = ""

  spec.files        = Dir['[A-Z]*', 'rakefile.rb', '*.gemspec'].reject { |f| f =~ /.lock/ }
  spec.files        += Dir['bin/**', 'lib/**/*.rb', 'test/**/*.rb', 'spec/**/*.rb', 'features/**/*.rb']
  spec.executables  = spec.files.grep( %r{^bin/} ) { |f| File.basename(f) }
  spec.test_files   = spec.files.grep( %r{^(test|spec|features)/} )

  # spec.add_runtime_dependency 'facets', '~> 3.0'
  # spec.add_runtime_dependency 'mustache', '~> 1.0'

  spec.add_development_dependency 'bundler', '~> 1.7'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'watch', '~> 0.1'
  spec.add_development_dependency 'rr', '~> 1.1'
  spec.add_development_dependency 'minitest', '~> 5.3'
  spec.add_development_dependency 'minitest-reporters', '~> 1.1'
end
