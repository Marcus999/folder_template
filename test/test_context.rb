
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

    describe "it implements DSL to support value lazzy definition" do
      let( :filename ) { 'path/to/context_file' }
      let( :content ) { "let( :bbb ) { aaa + 1 if aaa }" }
      subject { Context.load_from_content( content, filename ) }

      it "holds definition for values declared in context DSL file" do
        subject.merge!( aaa:123 )
        subject[:bbb].must_equal( 124 )
      end
    end


    describe "it behaves like a Hash" do
      subject {
        ctx = Context.new
        ctx.let( :bbb ) { aaa + 1 }
        ctx.let( :aaa ) { 123 }
        ctx
      }

      it "supports value accessor with symbols" do
        subject[:bbb].must_equal( 124 )
      end

      it "supports value assignment with symbols" do
        subject[:aaa] = 112
        subject[:aaa].must_equal( 112 )
      end

      it "updates evaluation of dependent variables after value assignment" do
        subject[:aaa] = 112
        subject[:bbb].must_equal( 113 )
      end

      it "responds to values like a Hash" do
        Set.new(subject.values).must_equal( Set.new([123, 124]) )
      end

      it "responds to each like a Hash" do
        kv_pairs = subject.each.to_a
        kv_pairs.must_equal( [[:bbb, 124], [:aaa, 123]] )
      end
    end # it behaves like a Hash


    describe "it can be copies with all definies variables" do
      subject {
        ctx = Context.new
        ctx.let( :ccc ) { aaa + bbb }
        ctx.let( :aaa ) { 123 }
        ctx
      }

      it "creates an independant contexts for each copy" do
        ctx1 = subject.dup
        ctx2 = subject.dup
        ctx1[:bbb] = 1
        ctx2[:bbb] = 2
        ctx1[:ccc].must_equal( 124 )
        ctx2[:ccc].must_equal( 125 )
      end

      it "merge() creates a duplicated instance of the conext" do
        ctx1 = subject.merge( bbb:1 )
        ctx2 = subject.merge( bbb:2 )
        ctx1[:ccc].must_equal( 124 )
        ctx2[:ccc].must_equal( 125 )
      end
    end


    describe "it caches pre-evaluated values" do
      subject { Context.new }

      it "evaluates values only once" do
        subject.let( :aaa ) { 123 }
        subject.aaa.must_equal( 123 )
        subject.definitions.delete( :aaa )
        subject.aaa.must_equal( 123 )
      end

      it "clears cached values when variables are re-declared" do
        subject.let( :aaa ) { 123 }
        subject.aaa.must_equal( 123 )
        subject.let( :aaa ) { 124 }
        subject.aaa.must_equal( 124 )
      end

      it "re-evalutes dependant values after a change of definition" do
        subject.let( :aaa ) { 123 }
        subject.let( :bbb ) { aaa + 1 }
        subject.bbb.must_equal( 124 )
        subject.let( :aaa ) { 124 }
        subject.bbb.must_equal( 125 )
      end
    end

  end # describe Context
end
