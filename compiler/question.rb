#!/usr/bin/env ruby
# coding: utf-8

$:.push(File.dirname(File.expand_path(__FILE__)))

require 'set'

# "?"クラス
class Question
    def initialize(node)
        @node = node
    end

    # 状態遷移の組み立て
    def assemble(context)
        fragment = @node.assemble(context)

        for state in fragment.accepts do
            fragment.connect(fragment.start, "", state)
        end

        return fragment
    end
end