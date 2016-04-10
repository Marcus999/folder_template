# =============================================================================
#  
# MODULE      : test/ruby_project_generator/template_string.rb
# PROJECT     : RubyProjectGenerator
# DESCRIPTION : 
#
# Copyright (c) 2016, Marc-Antoine Argenton.  All rights reserved.
# =============================================================================


require '_test_env.rb'


module FolderTemplate
  describe TemplateFolderEntry do
    
    describe "when initialized for directory entry" do
      let(:filename)    { "lib/{{project_name}}" }
      let(:content)     { nil }
      subject           { TemplateFolderEntry.new( filename, content ) }

      it "parses filename into a TemplateString" do
        subject.filename_template.must_be_kind_of TemplateString
      end

      it "parses filename correctly" do
        "#{subject.filename_template}".must_equal filename
      end

      it "sets content_template to nil" do
        subject.content_template.must_be_nil
      end

      
      describe "when asking for variables" do
        it "returns filename variables" do
          subject.variables.must_equal subject.filename_template.variables
        end
      end
      
      describe "when calling generate" do
        let(:fs) { MiniTest::Mock.new }
        let(:env) { Hash.new.merge( project_name:"aaa", class_filename:"bbb" ) }

        it "expands content and filename and invokes fs.write_to_file()" do
          expected_filename = subject.filename_template.expand( env ).to_s
          fs.expect :makedirs, nil, [expected_filename]

          subject.generate( fs, env )
        end
      end
      
    end

    describe "when initialized for file entry" do
      let(:filename)    { "lib/{{project_name}}/{{project_name}}.rb" }
      let(:content)     { "# {{filename}}\n\nrequire_relative 'lib/{{project_name}}/{{class_filename}}.rb'" }
      subject           { TemplateFolderEntry.new( filename, content ) }
      
      it "parses filename into a TemplateString" do
        subject.filename_template.must_be_kind_of TemplateString
      end

      it "parses filename correctly" do
        "#{subject.filename_template}".must_equal filename
      end

      it "prases content into TemplateString" do
        subject.content_template.must_be_kind_of TemplateString
      end

      it "parses content correctly" do
        "#{subject.content_template}".must_equal content
      end
      
      describe "when asking for variables" do
        it "returns a union set of filename and content variables" do
          expected_variables = subject.filename_template.variables + subject.content_template.variables
          subject.variables.must_equal expected_variables
        end
      end
      
      describe "when calling generate" do
        let(:fs) { MiniTest::Mock.new }
        let(:env) { Hash.new.merge( project_name:"aaa", class_filename:"bbb" ) }

        it "expands content and filename and invokes fs.write_to_file()" do
          expected_filename = subject.filename_template.expand( env ).to_s
          expected_content = subject.content_template.expand( env.merge( filename:expected_filename) ).to_s
          fs.expect :write_to_file, nil, [expected_filename, expected_content]

          subject.generate( fs, env )
        end
      end
    end

    describe "when initialized for append entry" do
      let(:filename)    { "lib/>>{{project_name}}.rb" }
      let(:content)     { "# {{filename}}\n\nrequire_relative 'lib/{{project_name}}/{{class_filename}}.rb'" }
      subject           { TemplateFolderEntry.new( filename, content ) }

      it "parses filename into a TemplateString" do
        subject.filename_template.must_be_kind_of TemplateString
      end

      it "removes append marker from filename template" do
        "#{subject.filename_template}".must_equal filename.gsub( ">>", "" )
      end

      it "marks entry as append" do
        subject.append.must_equal true
      end

      it "prases content into TemplateString" do
        subject.content_template.must_be_kind_of TemplateString
      end

      it "parses content correctly" do
        "#{subject.content_template}".must_equal content
      end


      describe "when asking for variables" do
        it "returns a union set of filename and content variables" do
          expected_variables = subject.filename_template.variables + subject.content_template.variables
          subject.variables.must_equal expected_variables
        end
      end

      describe "when calling generate" do
        let(:fs) { MiniTest::Mock.new }
        let(:env) { Hash.new.merge( project_name:"aaa", class_filename:"bbb" ) }

        it "expands content and filename and invokes fs.write_to_file()" do
          expected_filename = subject.filename_template.expand( env ).to_s
          expected_content = subject.content_template.expand( env.merge( filename:expected_filename) ).to_s
          fs.expect :append_to_file, nil, [expected_filename, expected_content]

          subject.generate( fs, env )
        end
      end
    end

  end # describe TemplateString
end


