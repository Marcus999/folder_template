# =============================================================================
#
# MODULE      : rakefile.rb
# PROJECT     : FolderName
# DESCRIPTION :
#
# Copyright (c) <<test_year>>, <<test_user>>.  All rights reserved.
# =============================================================================


require 'bundler/gem_tasks'
require 'rake/testtask'

PROJECT_CONTEXT = {
  project_name:       "folder_name",
  project_namespace:  "FolderName",
  copyright_owner:    "<<test_user>>",
  copyright_year:     "<<test_year>>",
}

Rake::TestTask.new do |t|
  t.libs << '.' << 'test'
  t.test_files = FileList['test/**/test_*.rb']
  t.verbose = false
end



begin
  require 'watch'
  w = `tput cols`.to_i || 80

  def tty_red(str);           "\e[31m#{str}\e[0m" end
  def tty_green(str);         "\e[32m#{str}\e[0m" end
  def tty_blink(str);         "\e[5m#{str}\e[25m" end
  def tty_reverse_color(str); "\e[7m#{str}\e[27m" end


  desc 'Run unit tests everytime a source or test file is changed'
  task :autotest do
    Watch.new( '**/*.rb' ) do
      success = system "clear && rake test"

      puts tty_green( "-" * w ) if success
      puts tty_reverse_color(tty_red( "-" * w )) if !success
    end
  end

  desc 'Alias for rake autotest'
  task watch: [:autotest]

rescue LoadError
  puts "'rake autotest' unavailable"
end

task default: [:test, :build]
