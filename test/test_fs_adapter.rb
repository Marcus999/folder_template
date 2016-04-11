# =============================================================================
#
# MODULE      : lib/ruby_project_generator/test_fs_adapter.rb
# PROJECT     : RubyProjectGenerator
# DESCRIPTION :
#
# Copyright (c) 2016, Marc-Antoine Argenton.  All rights reserved.
# =============================================================================


require '_test_env.rb'


module FolderTemplate

  describe FsAdapter do
    let( :tmpdir ) { "tmp" }
    subject { FsAdapter.new( tmpdir ) }

    before do
      stub(FileUtils).makedirs()
      stub(File).open()
      stub(File).write()
    end

    describe "when calling makedirs()" do
      it "expands filename and calls FileUtils.makedirs()" do
        mock(FileUtils).makedirs( File.join( tmpdir, "aaa/bbb" ) )
        subject.makedirs( "aaa/bbb" )
      end
    end

    describe "when calling write_to_file()" do
      it "expands filename, creates containing folder and calls File.write()" do
        expected_filename = File.join( tmpdir, "aaa/bbb" )
        mock(FileUtils).makedirs( File.dirname( expected_filename ) )
        mock(File).write( expected_filename, "bbb" )

        subject.write_to_file( "aaa/bbb", "bbb" )
      end
    end

    describe "when calling append_to_file()" do
      it "expands filename, opens file for append and appends content" do
        expected_filename = File.join( tmpdir, "aaa/bbb" )
        mock(FileUtils).makedirs( File.dirname( expected_filename ) )
        mock(File).open( expected_filename, "a" )

        subject.append_to_file( "aaa/bbb", "bbb" )
      end
    end
  end

end
