#!/usr/bin/env ruby
# coding: utf-8

$:.push(File.dirname(File.expand_path(__FILE__)))

require 'set'

# NFAクラス
class NondeterministicFiniteAutomation
    attr_reader :start, :accepts

    def initialize(map, start, accepts, dotStateList)
        @map = map
        @start = start
        @accepts = accepts
        @dotStateList = dotStateList
    end

    # イプシロン展開を実行
    def epsilonExpand(set)
        queue = []
        set.each do |state|
            queue.push(state)
        end
        done = Set.new()

        while !queue.empty? do
            state = queue.pop
            nextStates = transition(state, "")
            done.add(state)

            nextStates.each do |nextState|
                unless done.include?(nextState) then
                    queue.push(nextState)
                end
            end
        end

        return done.freeze
    end

    # 状態遷移を実行
    def transition(state, character)
        if @dotStateList.include?(state) then
            character = "."
        end

        nextState = @map[Set.new([state, character])]
        unless nextState then
            nextState = Set.new()
        end

        return nextState 
    end
end