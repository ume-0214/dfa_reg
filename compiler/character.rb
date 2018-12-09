#!/usr/bin/env ruby
# coding: utf-8

$:.push(File.dirname(File.expand_path(__FILE__)))

require 'set'
require 'nfaFragment'

# 文字のクラス
class Character
    def initialize(char)
        @char = char
    end

    # 状態遷移の組み立て
    def assemble(context)
        fragment = NFAFragment.new()
        s1 = context.newState()
        s2 = context.newState()
        fragment.connect(s1, @char, s2)

        fragment.start = s1
        fragment.accepts = Set.new([s2]).freeze

        return fragment
    end
end