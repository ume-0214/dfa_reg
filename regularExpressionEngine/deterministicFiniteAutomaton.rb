#!/usr/bin/env ruby
# coding: utf-8

$:.push(File.dirname(File.expand_path(__FILE__)))

require 'set'

# DFAクラス
class DeterministicFiniteAutomaton
    def initialize(nfa)
        @start = nfa.epsilonExpand(Set.new([nfa.start]).freeze)
        @accepts = nfa.accepts
        @nfa = nfa
        @currentState = @start
    end

    # 文字列を1文字ずつ読み込み状態遷移を実行
    def run(string)
        matchList = []
        maxLengthString = nil
        stringList = string.split("")

        stringList.each do |character|
            transition(character)

            unless @currentState.size == 0 then
                matchList.push(character)
            end

            unless (@accepts & @currentState).size == 0 then
                maxLengthString = matchList.clone
            end
        end

        return maxLengthString
    end

    # 状態の遷移を実行
    def transition(character)
        ret = Set.new()
        @currentState.each do |element|
            ret = ret | @nfa.transition(element, character)
        end

        @currentState = @nfa.epsilonExpand(ret.freeze)
    end
end