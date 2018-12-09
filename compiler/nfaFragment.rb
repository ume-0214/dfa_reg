#!/usr/bin/env ruby
# coding: utf-8

$:.push(File.dirname(File.expand_path(__FILE__)))

require 'set'
require 'regularExpressionEngine/nondeterministicFiniteAutomation'

# NFAの構成部品クラス
class NFAFragment
    attr_accessor :start, :accepts, :map, :dotStateList

    def initialize()
        @start = nil
        @accepts = nil
        @map = Hash.new()
        @dotStateList = []
    end

    # 遷移関数作成
    def connect(from, character, to)
        if character.eql?(".") then
            @dotStateList.push(from)
        end

        key = Set.new([from, character])
        if @map.key?(key) then
            @map[key].add(to)
        else
            @map.store(key, Set.new([to]))
        end
    end

    # 現在の遷移関数をコピーしたフラグメントを取得
    def copyFragment()
        newFragment = NFAFragment.new()
        newFragment.map = @map.clone
        newFragment.dotStateList = @dotStateList.clone

        return newFragment
    end

    # 遷移関数の論理和
    def or(frag)
        newFrag = copyFragment()
        frag.map.each do |key, value|
            newFrag.map[key] = value
        end

        return newFrag
    end

    # NFA作成
    def build()
        return NondeterministicFiniteAutomation.new(@map, @start, @accepts, @dotStateList)
    end
end