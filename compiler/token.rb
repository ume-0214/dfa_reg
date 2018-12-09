#!/usr/bin/env ruby
# coding: utf-8

$:.push(File.dirname(File.expand_path(__FILE__)))

class Token
    attr_reader :value, :kind

    # トークンの種類
    CHARACTER = 0
    STAR = 1
    QUESTION = 2
    EOF = 3

    def initialize(value, kind)
        @value = value
        @kind = kind
    end
end