# =============================================================================
#  
# MODULE      : test/project_aaa/test_cls1_fn.rb
# PROJECT     : ProjectAaa
# DESCRIPTION : 
#
# Copyright (c) YEAR, Me.  All rights reserved.
# =============================================================================

module ProjectAaa
  
  describe Cls1Name do
    subject { Cls1Name.new }
    
    it "passes this one" do
      subject.must_be_instance_of Cls1Name
    end
  end

end
