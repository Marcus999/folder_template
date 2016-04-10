# =============================================================================
#
# MODULE      : folder_template.gemspec
# PROJECT     : FolderTemplate
# DESCRIPTION :
#
# Copyright (c) 2016, Marc-Antoine Argenton.  All rights reserved.
# =============================================================================


require_relative 'lib/folder_template/version.rb'

Gem::Specification.new do |spec|
  spec.name         = 'folder_template'
  spec.version      = FolderTemplate::VERSION
  spec.authors      = ["Marc-Antoine Argenton"]
  spec.email        = ["maargenton.dev@gmail.com"]
  spec.summary      = "Simple and generic folder structure template engine"
  spec.description  = %q{ FolderTemplate is a minimalistic template engine that generates files and
                          folders structure from a template folder layout. It includes a simple variable
                          expansion syntax, automatically injects variables for filename and basename,
                          and can optionally append content to existing files.
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
end
