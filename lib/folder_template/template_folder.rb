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
    attr_reader :entries
    
    def initialize( path )
      @entries = _load_template( path )
    end
    
    def variables
      @variables ||= entries.each_with_object( Set.new ) do |e, variables|
        variables.merge( e.variables )
      end
    end

    def generate( fs, **env )
      entries.each do |entry|
        entry.generate( fs, env )
      end
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














