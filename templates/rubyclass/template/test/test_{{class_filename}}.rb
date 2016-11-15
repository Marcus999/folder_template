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
  describe {{class_name}} do

    subject { {{class_name}}.new }

    it "passes this one" do
      subject.must_be_instance_of {{class_name}}
    end

  end
end
