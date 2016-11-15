# =============================================================================
#
# MODULE      : {{filename}}
# PROJECT     : {{project_namespace}}
# DESCRIPTION :
#
# Copyright (c) {{copyright_year}}, {{copyright_owner}}.  All rights reserved.
# =============================================================================

require 'minitest/autorun'
require 'minitest/reporters'
require 'fileutils'
require 'pp'
require 'rr'

require 'lib/{{project_name}}.rb'

# Minitest::Reporters.use! [Minitest::Reporters::SpecReporter.new]


module Minitest::Assertions
  def assert_custom( expected, actual )
    assert false, "assert_custom() always fails\n" +
                  "  Expected: #{expected.inspect}\n" +
                  "  Actak:    #{actual.inspect}\n"
  end
end
