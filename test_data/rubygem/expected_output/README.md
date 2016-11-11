# FolderTemplate

[![Gem Version](https://badge.fury.io/rb/folder_template.svg)](https://badge.fury.io/rb/folder_template)
[![Build Status](https://travis-ci.org/marcus999/folder_template.svg?branch=master)](https://travis-ci.org/marcus999/folder_template)
[![Code Climate](https://codeclimate.com/github/Marcus999/folder_template/badges/gpa.svg)](https://codeclimate.com/github/Marcus999/folder_template)
[![Issue Count](https://codeclimate.com/github/Marcus999/folder_template/badges/issue_count.svg)](https://codeclimate.com/github/Marcus999/folder_template)




FolderTemplate is a minimalistic template engine that generates files and
folders structure from a template folder layout. It includes a simple variable
expansion syntax, automatically injects variables for filename and basename,
and can optionally append content to existing files.


## Template definitions

- Templates are defined as files and folders on disk
- Variables are surrounded with double curly: `{{variable}}`
- Variables can be part of filenames, folder names, and file content
- Template filename with a `>>` prefix will append their content to an existing file


## Usage

```ruby
require 'folder_template'

template = FolderTemplate::TemplateFolder.new( template_path )
fs = FolderTemplate::FsAdapter.new( output_path, opts... )
env = Hash.new.merge( project_name:"my_project", ... )

template.generate( fs, env )
```


## FsAdapter

All filesystem operation are abstracted through an `FsAdapter` object that
performs final filename expansion, and execute all filesystem manipulations.

The `FsAdapter` interface is composed of 3 methods; any class implementing
those 3 methods can be used in place of the default `FsAdapter` object to
perform the necessary filesystem operations.

```ruby
def makedirs( dirname )
def write_to_file( filename, content )
def append_to_file( filename, content )
```

Default implementation of `FsAdapter` accepts a few options:

| Option             | Default | Description           |
| ------------------ |---------|-----------------------|
| `verbose`          | `false` | When `true`, log each operation that is performed |
| `overwrite_files`  | `false` | When `true`, replace existing files with content generated from template |











# Project

Welcome to your new gem! In this directory, you'll find the files you need to be able to package up your Ruby library into a gem. Put your Ruby code in the file `lib/__project__`. To experiment with that code, run `bin/console` for an interactive prompt.

TODO: Delete this and the text above, and describe your gem

## Installation

Add this line to your application's Gemfile:

```ruby
gem '__project__'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install __project__

## Usage

TODO: Write usage instructions here

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release` to create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

1. Fork it ( https://github.com/[my-github-username]/__project__/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
