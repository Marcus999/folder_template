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
  describe Context do

    describe "initialized with new" do
      subject { Context.new }

      describe "calling let on context" do
        it "adds value definition to the contex" do
          subject.let( :aaa ) { 123 }
          subject.evaluate().must_equal( { aaa:123 } )
        end

        it "supports out of order definition on value reference" do
          subject.let( :bbb ) { aaa + 1 }
          subject.let( :aaa ) { 123 }
          subject.evaluate().must_equal( { aaa:123, bbb:124 } )
        end

        it "supports dependecies on evaluation injected values" do
          subject.let( :bbb ) { aaa + 1 if aaa }
          subject.evaluate( aaa:123 ).must_equal( { aaa:123, bbb:124 } )
        end
      end
    end


    describe "initialized with load" do
      let( :content ) { "let( :bbb ) { aaa + 1 if aaa }" }
      let( :filename ) { "context_filename.rb"}
      subject { Context.load_from_content( content, filename ) }

      it "supports dependecies on evaluation injected values" do
        subject.evaluate( aaa:123 ).must_equal( { aaa:123, bbb:124 } )
      end

    end

  end # describe Context
end
