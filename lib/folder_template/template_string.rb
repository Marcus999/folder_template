# =============================================================================
#
# MODULE      : lib/folder_template/template_string.rb
# PROJECT     : FolderTemplate
# DESCRIPTION :
#
# Copyright (c) 2016, Marc-Antoine Argenton.  All rights reserved.
# =============================================================================

module FolderTemplate
  class TemplateString
    attr_reader :content

    def initialize( template )
      case template
      when String
        @content = _parse( template )
      when Array
        @content = template.select do |fragment|
          !fragment.nil? && !fragment.empty?
        end
      when TemplateString
        @content = template.content
      end
    end

    def variables
      @variables ||= _extract_variables( @content )
    end

    def expand( **env )
      fragments = content.map do |fragment|
        case fragment
        when Symbol
          env[fragment] || (yield fragment if block_given?)|| fragment
        else
          fragment
        end
      end.select { |fragment| !fragment.nil? && !fragment.empty? }
      TemplateString.new( fragments )
    end

    def to_s
      @content.map do |fragment|
        ("{{#{fragment}}}" if Symbol === fragment) || fragment
      end.join
    end

  private
    VARIABLE_PATTERN = /{{(\w+)}}/

    def _parse( template )
      result = []
      tail = template
      loop do
        head, _token, tail = tail.partition( VARIABLE_PATTERN )
        result << head if !head.empty?
        break if $1.nil?
        result << $1.to_sym
      end
      result
    end

    def _extract_variables( content )
      Set.new( content.select { |s| Symbol === s } )
    end
  end
end
