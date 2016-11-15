# =============================================================================
#
# MODULE      : lib/folder_template/setup_folder_cmd.rb
# PROJECT     : FolderTemplate
# DESCRIPTION :
#
# Copyright (c) 2016, Marc-Antoine Argenton.  All rights reserved.
# =============================================================================


module FolderTemplate
  class SetupFolderCmd
    attr_reader :target_path
    attr_reader :template_name
    attr_reader :variables

    attr_reader :registry
    attr_reader :template_path

    def initialize( *args )
      parse_args( args.flatten )
      @registry = TemplateRegistry.registry_with_default_locations()
      @template_path = registry.path_for_template( template_name )
    end

    def self.run( *args, **env )
      self.new( args ).run( env )
    end


    def run( **env )
      template = FolderTemplate::TemplateFolder.new( template_path )
      fs = FolderTemplate::FsAdapter.new( target_path, verbose:true )
      template.generate( fs, variables.merge( target_path:target_path ).merge( env ) )
    end

  private
    def parse_args( args )
      raise "Missing required target_path and template_name arguments" unless args.count >= 2

      @target_path = File.expand_path( args.shift )
      @template_name = args.shift

      @variables = {}
      args.delete_if do |s|
        m = /(\w+)=(.*)/.match(s)
        @variables[m[1].to_sym] = m[2] if m
        m
      end
    end
  end # class SetupFolderCmd
end # module FolderTemplate
