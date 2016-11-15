# =============================================================================
#
# MODULE      : lib/folder_template/template_folder.rb
# PROJECT     : FolderTemplate
# DESCRIPTION :
#
# Copyright (c) 2016, Marc-Antoine Argenton.  All rights reserved.
# =============================================================================

module FolderTemplate

  class TemplateFolder
    attr_reader :base_path
    attr_reader :file_templates
    attr_reader :context

    def initialize( path )
      @base_path = path

      file_templates_path = File.join( path, "template" )
      @file_templates = _load_template( file_templates_path )

      context_filename = File.join( path, "context.rb" )
      @context = Context.load( context_filename ) if File.readable?( context_filename )
      @context ||= Context.new
    end

    def variables
      @variables ||= @file_templates.each_with_object( Set.new ) do |e, variables|
        variables.merge( e.variables )
      end
    end

    def generate( fs, env )
      file_templates.each do |entry|
        entry.generate( fs, context.merge( env ) )
      end
    end

    def self.validate_template_path( path )
      File.readable?( File.join( path.to_s, "context.rb" ) ) &&
          File.directory?( File.join( path.to_s, "template" ) )
    end

  private
    def _load_template( path )
      prefix = File.join( path, "" )

      Dir[File.join( path, "**", "*")].map do |source|
        filename = source.gsub( prefix, '' )
        content = File.read( source ) if !File.directory?( source )
        TemplateFolderEntry.new( filename, content )
      end
    end
  end # class TemplateFolder

end
