# rubygem/context.rb

# Required variables:
# - name : The name of the class to be created

# Variables inherited from project context
# - project_name
# - project_namespace
# - copyright_owner
# - copyright_year


let( :class_filename )      { name.underscore }
let( :class_name )          { class_filename.capitalize.camelcase }
let( :_ )                   { '' }
