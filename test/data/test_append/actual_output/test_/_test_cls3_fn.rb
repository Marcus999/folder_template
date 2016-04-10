# =============================================================================
#  
# MODULE      : test/project_aaa/test_cls3_fn.rb
# PROJECT     : ProjectAaa
# DESCRIPTION : 
#
# Copyright (c) YEAR, Me.  All rights reserved.
# =============================================================================

module ProjectAaa
  
  describe Cls3Name do
    subject { Cls3Name.new }
    
    it "passes this one" do
      subject.must_be_instance_of Cls3Name
    end
  end

end
