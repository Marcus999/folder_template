# =============================================================================
#
# MODULE      : lib/ruby_project_generator.rb
# PROJECT     : RubyProjectGenerator
# DESCRIPTION :
#
# Copyright (c) 2016, Marc-Antoine Argenton.  All rights reserved.
# =============================================================================

require 'fileutils'
require 'facets'


module FolderTemplate
  BASE_PATH = File.expand_path( File.join( File.dirname( __FILE__ ), ".." ) )
end

require_relative 'folder_template/version.rb'
require_relative 'folder_template/fs_adapter.rb'
require_relative 'folder_template/template_string.rb'
require_relative 'folder_template/template_folder_entry.rb'
require_relative 'folder_template/template_folder.rb'
require_relative 'folder_template/context.rb'
