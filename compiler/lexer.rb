#!/usr/bin/env ruby
# coding: utf-8

$:.push(File.dirname(File.expand_path(__FILE__)))

require 'token'

# 字句解析クラス
class Lexer
    def initialize(string)
        @stringList = string.split("")
    end

    # 一文字読み込み
    def scan()
        if @stringList.empty? then
            return Token.new(nil, Token::EOF)
        end

        char = @stringList.shift

        if char.eql?("*") then
            return Token.new(char, Token::STAR)
        elsif char.eql?("?") then
            return Token.new(char, Token::QUESTION)
        else
            return Token.new(char, Token::CHARACTER)
        end
    end
end