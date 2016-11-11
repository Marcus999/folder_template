# =============================================================================
#
# MODULE      : {{filename}}
# PROJECT     : {{project_namespace}}
# DESCRIPTION :
#
# Copyright (c) {{copyright_year}}, {{copyright_owner}}.  All rights reserved.
# =============================================================================


require '_test_env.rb'

module {{project_namespace}}

  describe Version do
    subject { VERSION }

    it "is definied as a string" do
      subject.must_be_instance_of String
    end
  end

end
