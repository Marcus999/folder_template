# rubygem/context.rb

# Required variables:
#  - target_path : path in which the template will be expanded


let( :folder_name )         { File.basename(target_path) }

let( :project_name )        { folder_name }
let( :project_namespace )   { folder_name.capitalize.camelcase }
let( :username )            { `id -F`.strip }
let( :copyright_owner )     { username }
let( :copyright_year )      { Time.now.year }

let( :_ )                   { '' } 
