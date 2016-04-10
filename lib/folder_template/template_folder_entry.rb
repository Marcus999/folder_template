# =============================================================================
#
# MODULE      : lib/folder_template/template_folder.rb
# PROJECT     : FolderTemplate
# DESCRIPTION :
#
# Copyright (c) 2016, Marc-Antoine Argenton.  All rights reserved.
# =============================================================================

module FolderTemplate

  class TemplateFolderEntry
    attr_reader :filename_template
    attr_reader :content_template
    attr_reader :append

    def initialize( filename, content )
      @append, filename = _filter_append_marker( filename )
      @filename_template = TemplateString.new( filename )
      @content_template = TemplateString.new( content ) if !content.nil?
    end

    def variables
      @variables ||= [filename_template, content_template].reject do |t|
        t.nil?
      end.each_with_object( Set.new ) do |t, variables|
        variables.merge( t.variables )
      end
    end


    def generate( fs, **env )
      filename = filename_template.expand( env ).to_s
      basename = File.basename( filename, File.extname( filename ) )

      if ( content_template )
        local_env = env.merge( filename:filename, basename:basename )
        content = content_template.expand( local_env ).to_s
        if ( append )
          fs.append_to_file( filename, content )
        else
          fs.write_to_file( filename, content )
        end
      else
        fs.makedirs( filename )
      end
    end

  private
    def _filter_append_marker( filename )
      basename = File.basename( filename )
      dirname = File.dirname( filename )

      return false, filename if !basename.start_with?( ">>" )
      return true, File.join( dirname, basename[2..-1] )
    end
  end # class TemplateFolderEntry

end
