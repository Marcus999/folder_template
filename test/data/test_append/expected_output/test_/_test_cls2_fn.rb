# =============================================================================
#  
# MODULE      : test/project_aaa/test_cls2_fn.rb
# PROJECT     : ProjectAaa
# DESCRIPTION : 
#
# Copyright (c) YEAR, Me.  All rights reserved.
# =============================================================================

module ProjectAaa
  
  describe Cls2Name do
    subject { Cls2Name.new }
    
    it "passes this one" do
      subject.must_be_instance_of Cls2Name
    end
  end

end
