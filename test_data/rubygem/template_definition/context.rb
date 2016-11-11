# rubygem/context.rb

let( :_ )                   { "" }
let( :project_name )        { folder_name }
let( :project_namespace )   { folder_name.capitalize.camelcase }
let( :username )            { `id -F`.strip }
let( :copyright_owner )     { username }
let( :copyright_year )      { Time.now.year }

# Overwrite for constant output for test puprose
let( :_ )                   { "_" }
let( :username )            { "<<test_user>>" }
let( :copyright_year )      { "<<test_year>>" }
