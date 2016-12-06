# =============================================================================
#
# MODULE      : lib/folder_template/template_registry.rb
# PROJECT     : FolderTemplate
# DESCRIPTION :
#
# Copyright (c) 2016, Marc-Antoine Argenton.  All rights reserved.
# =============================================================================



module FolderTemplate
  class TemplateRegistry

    attr_reader :template_locations

    def initialize
      @template_locations = {}
    end

    def self.registry_with_default_locations()
      r = TemplateRegistry.new
      r.scan_location( File.join( BASE_PATH, "templates" ) )
      r.scan_location( File.expand_path( "~/.folder_template" ) )
      r
    end

    def scan_location( base_path )
      _list_template_folders( base_path ).each do |path|
        _register_template_path( path )
      end
      self
    end

    def path_for_template( template_name )
      path_list = @template_locations[template_name]
      path_list.first if path_list
    end

    # def upscan_location( base_path )
    # end


  private
    def _list_template_folders( base_path )
      Dir[File.join( base_path, "*")].select do |path|
        File.directory?(path) && TemplateFolder.validate_template_path( path )
      end
    end

    def _register_template_path( path )
      template_name = File.basename( path )
      @template_locations[template_name] ||= []
      @template_locations[template_name].unshift( path )
    end


    # def upscan_directories( start_path )
    #   path = File.expand_path( start_path )
    #   result = []
    #   loop do
    #     result << path
    #     parent_path = File.dirname( path )
    #     break if parent_path == path
    #     path = parent_path
    #   end
    #   result
    # end

  end # class TemplateLocator
end # module FolderTemplate
