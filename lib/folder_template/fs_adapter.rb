# =============================================================================
#
# MODULE      : lib/folder_template/fs_adapter.rb
# PROJECT     : FolderTemplate
# DESCRIPTION :
#
# Copyright (c) 2016, Marc-Antoine Argenton.  All rights reserved.
# =============================================================================

module FolderTemplate

  class FsAdapter
    attr_reader :base_path
    attr_reader :opts

    def initialize( base_path, **opts )
      @base_path = base_path
      @opts = opts
    end

    def makedirs( dirname )
      target = File.join( base_path, dirname )
      return if ( File.directory?( target ) )

      puts "Creating diectory #{dirname} ..." if opts[:verbose]
      FileUtils.makedirs( target )
    end

    def write_to_file( filename, content )
      target = File.join( base_path, filename )

      if ( File.exist?( target ) && ! opts[:overwrite_files] )
        puts "Skiping file #{filename} ..." if opts[:verbose]
      else
        puts "Generating file #{filename} ..." if opts[:verbose]
        FileUtils.makedirs( File.dirname( target ) )
        File.write( target, content )
      end
    end

    def append_to_file( filename, content )
      target = File.join( base_path, filename )

      puts "Appending content to file #{filename} ..." if opts[:verbose]
      FileUtils.makedirs( File.dirname( target ) )
      File.open( target, "a" ) { |f| f.write( content ) }
    end
  end # class FsAdapter

end
