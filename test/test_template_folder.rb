# =============================================================================
#
# MODULE      : lib/ruby_project_generator/version.rb
# PROJECT     : RubyProjectGenerator
# DESCRIPTION :
#
# Copyright (c) 2016, Marc-Antoine Argenton.  All rights reserved.
# =============================================================================


require '_test_env.rb'


module FolderTemplate

  describe TemplateFolder do
    let( :data_base_path )        { File.join( FolderTemplate::BASE_PATH, 'test_data' ) }
    let( :template )              { TemplateFolder.new( File.join( data_base_path, data_test_name, 'template_definition' ) ) }
    let( :expected_output_path )  { File.join( data_base_path, data_test_name, 'expected_output' ) }
    let( :actual_output_path )    { File.join( data_base_path, data_test_name, 'actual_output' ) }
    # let( :base_env ) { Hash.new.merge(  project_name:       'project_aaa',
    #                                     project_namespace:  'ProjectAaa',
    #                                     copyright_owner:    'Me',
    #                                     copyright_year:     'YEAR' ) }

    before do
      FileUtils.rm_rf( actual_output_path )
      FileUtils.makedirs( actual_output_path )
    end

    # describe "test1" do
    #   let( :data_test_name ) { 'test1' }
    #   let( :env ) { base_env.merge( class_filename:'cls_fn', class_name:'ClsName' ) }
    #
    #   it "" do
    #     fs = FsAdapter.new( actual_output_path, verbose:false )
    #     template.generate(  fs, env )
    #
    #     assert_folders_match( expected_output_path, actual_output_path )
    #   end
    # end

    describe "rubygem" do
      let( :data_test_name ) { 'rubygem' }
      let( :env ) { {}.merge( folder_name:'folder_name' ) }

      it "" do
        fs = FsAdapter.new( actual_output_path, verbose:false )
        template.generate(  fs, env )

        assert_folders_match( expected_output_path, actual_output_path )
      end
    end

    # describe "test_append" do
    #   let( :data_test_name ) { 'test_append' }
    #   let( :env ) { base_env }
    #
    #   it "" do
    #     fs = FsAdapter.new( actual_output_path, verbose:false )
    #     template.generate(  fs, env.merge( class_filename:'cls1_fn', class_name:'Cls1Name') )
    #     template.generate(  fs, env.merge( class_filename:'cls2_fn', class_name:'Cls2Name') )
    #     template.generate(  fs, env.merge( class_filename:'cls3_fn', class_name:'Cls3Name') )
    #
    #     assert_folders_match( expected_output_path, actual_output_path )
    #   end
    # end


  end # describe TemplateFolder

end
