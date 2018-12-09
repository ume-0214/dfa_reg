#!/usr/bin/env ruby
# coding: utf-8

$:.push(File.dirname(File.expand_path(__FILE__)))

require 'set'

# "*"クラス
class Star
    def initialize(node)
        @node = node
    end

    # 状態遷移の組み立て
    def assemble(context)
        fragOrig = @node.assemble(context)
        frag = fragOrig.copyFragment()

        for state in fragOrig.accepts do
            frag.connect(state, "", fragOrig.start)
        end

        s = context.newState()
        frag.connect(s, "", fragOrig.start)

        frag.start = s
        frag.accepts = fragOrig.accepts | Set.new([s]).freeze
        frag.dotStateList = fragOrig.dotStateList

        return frag
    end
end