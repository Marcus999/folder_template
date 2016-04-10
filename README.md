# FolderTemplate

[![Gem Version](https://badge.fury.io/rb/rr.svg)](http://badge.fury.io/rb/rr)
[![Build Status](https://travis-ci.org/rr/rr.svg?branch=master)](https://travis-ci.org/rr/rr)
[![Code Climate GPA](https://codeclimate.com/github/rr/rr.svg)](https://codeclimate.com/github/rr/rr)


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
