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
  describe TemplateString do

    describe "when initialized with a string" do
      let(:template_string) { "prefix {{arg1}} infix {{arg2}} suffix" }
      subject { TemplateString.new( template_string )}

      it "parses template string into an Array" do
        subject.content.must_be_kind_of Array
      end

      it "splits definition into Strings and Symbols" do
        content_types = Set.new( subject.content.map { |e| e.class } )
        content_types.must_equal Set.new( [String, Symbol] )
      end

      it "splits definition into constituant parts" do
        subject.content.must_equal ["prefix ", :arg1, " infix ", :arg2, " suffix"]
      end

      it "extracts variables from definition string" do
        subject.variables.must_equal Set.new( [:arg1, :arg2] )
      end

      it "evaluates to original template string" do
        "#{subject}".must_equal template_string
      end
    end


    describe "when initialized special string" do
      it "finds all variables" do
        template = TemplateString.new( "{{arg0}}{{arg1}} prefix {{arg2}}{{arg3}} suffix {{arg4}}{{arg5}}" )
        template.variables.must_equal Set.new( [:arg0, :arg1, :arg2, :arg3, :arg4, :arg5] )
      end

      it "keeps only non empty strings" do
        template = TemplateString.new( "{{arg0}}{{arg1}} prefix {{arg2}}{{arg3}} suffix {{arg4}}{{arg5}}" )
        strings = template.content.select{ |s| String === s }
        strings.must_equal( [" prefix ", " suffix "])
      end

    end

    describe "calling expand" do
      let(:template_string) { "prefix {{arg1}} infix {{arg2}} suffix" }
      subject { TemplateString.new( template_string )}

      it "expands variables using environment" do
        "#{subject.expand( arg1:"aaa", arg2:"bbb")}".must_equal "prefix aaa infix bbb suffix"
      end

      it "preserves undefined variables" do
        "#{subject.expand( arg1:"aaa" )}".must_equal "prefix aaa infix {{arg2}} suffix"
      end

      it "passes undefined variables to block" do
        result = subject.expand( arg1:"aaa" ) do |variable|
          "<#{variable}>"
        end
        "#{result}".must_equal "prefix aaa infix <arg2> suffix"
      end

      it "preserves template variable when block returns nil" do
        result = subject.expand( arg1:"aaa" ) do |variable|
          nil
        end
        "#{result}".must_equal "prefix aaa infix {{arg2}} suffix"
      end

      it "removes undefined variables when block returns empty string" do
        result = subject.expand( arg1:"aaa" ) do |variable|
          ""
        end
        "#{result}".must_equal "prefix aaa infix  suffix"
      end

    end

    describe "when using bare undersore variable" do
      let(:template_string) { "{{_}}.gitignore" }
      subject { TemplateString.new( template_string )}

      it "accepts bare underscore variable" do
        subject.variables.must_equal Set.new( [:_] )
      end

      it "can expand bare underscore to nothing" do
        result = subject.expand( _: "" )
        "#{result}".must_equal ".gitignore"
      end
    end

  end # describe TemplateString
end
