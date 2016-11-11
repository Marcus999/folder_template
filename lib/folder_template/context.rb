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

    def initialize()
      @definitions = Hash.new()
      @values_cache = {}
    end

    def initialize_copy( other )
      @definitions = other.definitions.dup
      @values_cache = {}
    end

    def self.load( filename )
      load_from_content( File.read( filename ), filename )
    end

    def self.load_from_content( content, filename )
      ctx = new
      ctx.instance_eval( content, filename )
      ctx
    end



    # -----------------------------------
    # Hash-like API
    # -----------------------------------

    def [](key)
      return _value_for_key( key )
    end

    def []=( key, value )
      @definitions[key] = value
      _clear_values_cache()
      self
    end

    def keys
      return @definitions.keys
    end

    def values
      return @definitions.keys.map { |k| _value_for_key(k) }
    end

    def each
      return enum_for(:each) unless block_given?
      @definitions.keys.each do |k|
        v = _value_for_key(k)
        yield k, v
      end
    end

    def merge!( h )
      h.each do |k,v|
        @definitions[k] = v
      end
      _clear_values_cache()
      self
    end

    def merge( h )
      self.dup.merge!( h )
    end


    # -----------------------------------
    # DSL exposed methods
    # -----------------------------------

    def let( key, &definition )
      @definitions[key] = definition
      _clear_values_cache()
      self
    end



    # -----------------------------------
    # Support methods for DSL implementation
    # -----------------------------------

    def method_missing( method, *args )
      return super unless args.empty?
      _value_for_key( method )
    end

  private
    def _value_for_key( key )
      return @values_cache[key] if @values_cache.include?( key )
      value = _evaluate_value_for_key( key )
      @values_cache[key] = value
      value
    end

    def _evaluate_value_for_key( key )
      value = @definitions[key]
      case value
      when Proc
        instance_eval( &value )
      else
        value
      end
    end

    def _clear_values_cache
      @values_cache = {} if !@values_cache.empty?
    end

  end # class Context
end # module FolderTemplate
