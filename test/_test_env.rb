# =============================================================================
#
# MODULE      : test/_test_env.rb
# PROJECT     : RubyProjectGenerator
# DESCRIPTION :
#
# Copyright (c) 2016, Marc-Antoine Argenton.  All rights reserved.
# =============================================================================

require 'minitest/autorun'
require 'minitest/reporters'
require 'fileutils'
require 'pp'
require 'rr'

require 'lib/folder_template.rb'

Minitest::Reporters.use! [Minitest::Reporters::SpecReporter.new]


module Minitest::Assertions
  def assert_folders_match( expected_folder, actual_folder )
    diffs = _diff_folders( expected_folder, actual_folder )
    assert diffs.empty?,
      "Expected folders content to match:\n#{diffs}\n"
      # "Expected folders to match:\nexpected: #{expected_folder.inspect}\nactual: #{expected_folder.inspect}\ndiffs:\n#{diffs}"
  end

private
  def _diff_folders( expected_folder, actual_folder )
    `diff -r -u --exclude=.DS_Store #{expected_folder} #{actual_folder}`
  end
end
