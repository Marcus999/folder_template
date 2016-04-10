# =============================================================================
#  
# MODULE      : test/project_aaa/test_cls_fn.rb
# PROJECT     : ProjectAaa
# DESCRIPTION : 
#
# Copyright (c) YEAR, Me.  All rights reserved.
# =============================================================================

module ProjectAaa
  
  describe ClsName do
    subject { ClsName.new }
    
    it "passes this one" do
      subject.must_be_instance_of ClsName
    end
  end

end
