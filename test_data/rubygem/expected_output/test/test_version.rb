# =============================================================================
#
# MODULE      : test/test_version.rb
# PROJECT     : FolderName
# DESCRIPTION :
#
# Copyright (c) <<test_year>>, <<test_user>>.  All rights reserved.
# =============================================================================


require '_test_env.rb'

module FolderName

  describe Version do
    subject { VERSION }

    it "is definied as a string" do
      subject.must_be_instance_of String
    end
  end

end
