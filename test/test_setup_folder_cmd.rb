# =============================================================================
#
# MODULE      : lib/ruby_project_generator/test_setup_folder_cmd.rb
# PROJECT     : RubyProjectGenerator
# DESCRIPTION :
#
# Copyright (c) 2016, Marc-Antoine Argenton.  All rights reserved.
# =============================================================================


require '_test_env.rb'


module FolderTemplate
  describe SetupFolderCmd do

    it "requires a least two command line arguments" do
      err = assert_raises RuntimeError do
        SetupFolderCmd.new()
      end
      err.message.must_match /missing/i
      err.message.must_match /required/i
      err.message.must_match /arguments/i
    end

    it "extracts target_path and template_name from argument list" do
      cmd = SetupFolderCmd.new( '.', 'rubygem' )
      cmd.target_path.must_equal( File.expand_path( '.' ) )
      cmd.template_name.must_equal( 'rubygem' )
    end

    it "parses variables definition" do
      cmd = SetupFolderCmd.new( '.', 'rubygem', 'aaa=123', 'bbb=234' )
      cmd.variables.must_equal( { aaa:'123', bbb:'234' } )
    end

    it "locates the template directory based on the requested name" do
      cmd = SetupFolderCmd.new( '.', 'rubygem', 'aaa=123', 'bbb=234' )
      cmd.template_path.wont_be_nil
      TemplateFolder.validate_template_path( cmd.template_path ).must_equal true
    end

  end # describe SetupFolderCmd
end # module FolderTemplate
