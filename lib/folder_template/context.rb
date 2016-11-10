# =============================================================================
#
# MODULE      : lib/folder_template/context.rb
# PROJECT     : FolderTemplate
# DESCRIPTION :
#
# Copyright (c) 2016, Marc-Antoine Argenton.  All rights reserved.
# =============================================================================

module FolderTemplate
  class Context

    attr_reader :definitions
    attr_reader :base_values

    def self.load( filename )
      load_from_content( File.read( filename ), filename )
    end

    def self.load_from_content( content, filename )
      ctx = new
      ctx.instance_eval( content, filename )
      ctx
    end

    def self.copy( ctx, **base_values )
      result = ctx.clone
      result._set_base_values( base_values )
      result
    end

    def initialize()
      @definitions = Hash.new()
      @base_values = nil
    end



    # -----------------------------------
    # DSL exposed methods
    # -----------------------------------

    def let( name, &definition )
      @definitions[name] = definition
      self
    end



    # -----------------------------------
    # Support methods for DSL implementation
    # -----------------------------------

    def evaluate( **args )
      return Context.copy( self, args ).evaluate() unless args.empty?

      result = @base_values.dup unless @base_values.nil?
      result ||= Hash.new()

      @definitions.keys.each { |k| result[k] = _value_for_key(k) }
      result
    end

    def method_missing( method, *args )
      return super unless args.empty?
      _value_for_key( method )
    end

    def _set_base_values( values )
      @base_values = values
    end

  private
    def _value_for_key( key )
      value = @base_values[key] unless @base_values.nil?
      value ||= @definitions[key]
      case value
      when Proc
        instance_eval( &value )
      else
        value
      end
    end

  end # class Context
end # module FolderTemplate
