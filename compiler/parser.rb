#!/usr/bin/env ruby
# coding: utf-8

$:.push(File.dirname(File.expand_path(__FILE__)))

require 'lexer'
require 'character'
require 'star'
require 'question'
require 'concat'
require 'context'

# 構文解析クラス
class Parser
    def initialize(lex)
        @lexer = lex
        @look = nil
        move()
    end

    def match(tag)
        unless @look.kind.eql?(tag)
            raise Exception.new("syntax error")
        end

        move()
    end

    # 一文字読み込み
    def move()
        @look = @lexer.scan()
    end
    
    # factor -> character
    def factor()
        node = Character.new(@look.value)
        match(Token::CHARACTER)

        return node
    end

    # symbol -> factor '*' | factor '?' | factor
    def symbol()
        node = factor()

        if @look.kind.eql?(Token::STAR) then
            match(Token::STAR)
            node = Star.new(node)
        elsif @look.kind.eql?(Token::QUESTION) then
            match(Token::QUESTION)
            node = Question.new(node)
        end

        return node
    end

    # symbol -> symbol seq | symbol
    def seq()
        node1 = symbol()

        if @look.kind.eql?(Token::CHARACTER) then
            node2 = seq()
            node = Concat.new(node1, node2)

            return node
        else
            return node1
        end
    end

    # expression -> seq EOF
    def expression()
        node = seq()
        match(Token::EOF)

        context = Context.new()
        fragment = node.assemble(context)

        return fragment.build()
    end
end