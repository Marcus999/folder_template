# =============================================================================
#
# MODULE      : lib/folder_template/template.rb
# PROJECT     : FolderTemplate
# DESCRIPTION :
#
# Copyright (c) 2016, Marc-Antoine Argenton.  All rights reserved.
# =============================================================================

module FolderTemplate
  class Template

    attr_reader :path
    attr_reader :context
    attr_reader :content

    def initialize( path )
      @path = path
      @context, @content = _load_template( path )
    end

    def self.from_name( name )
      path = _find_path_from_name( name )
      return nil if path.nil?
      return new( path )
    end

    def self.list_templates()
      Dir[File.join( BASE_PATH, "templates", "*" )].select do |path|
        _validate_template_path( path )
      end.map { |path| File.basename( path )  }
    end

    def generate( output_path )
      fs = FolderTemplate::FsAdapter.new( output_path, overwrite_files:true, verbose:true )
      folder_name = File.basename( output_path )
      env = context.evaluate( folder_name:folder_name )
      pp env
      # content.generate( fs, env )
    end

  private
    def self._find_path_from_name( name )
      path = File.join( BASE_PATH, "templates", name.to_s )
      return path if _validate_template_path( path )
    end

    def self._validate_template_path( path )
      File.readable?( File.join( path.to_s, "context.rb" ) ) &&
      File.directory?( File.join( path.to_s, "template" ) )
    end


    def _load_template( path )
      context = Context.load( File.join( path, "context.rb" ) )
      content = TemplateFolder.new( File.join( path, "template" ) )

      [context, content]
    end

  end # class Template
end # module FolderTemplate
