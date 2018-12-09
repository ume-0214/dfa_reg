#!/usr/bin/env ruby
# coding: utf-8

$:.push(File.dirname(File.expand_path(__FILE__)))

require 'compiler/lexer'
require 'compiler/parser'
require 'regularExpressionEngine/deterministicFiniteAutomaton'

inputString = gets
regexpString = gets

inputString.chomp!
regexpString.chomp!

lex = Lexer.new(regexpString)
parser = Parser.new(lex)
nfa = parser.expression()
dfa = DeterministicFiniteAutomaton.new(nfa)

maxLength = -1
while inputString.length != 0 do
    dfa = DeterministicFiniteAutomaton.new(nfa)
    maxLengthString = dfa.run(inputString)
    unless maxLengthString.nil? then
        if maxLength < maxLengthString.length then
            maxLength = maxLengthString.length
        end
    end 

    inputString.slice!(0)
end

p maxLength
