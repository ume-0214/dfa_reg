#!/usr/bin/env ruby
# coding: utf-8

$:.push(File.dirname(File.expand_path(__FILE__)))

# 文字と文字の連結クラス
class Concat
    def initialize(node1, node2)
        @node1 = node1
        @node2 = node2
    end

    # 状態遷移の組み立て
    def assemble(context)
        frag1 = @node1.assemble(context)
        frag2 = @node2.assemble(context)

        frag = frag1.or(frag2)

        for state in frag1.accepts do
            frag.connect(state, "", frag2.start)
        end

        frag.start = frag1.start
        frag.accepts = frag2.accepts
        frag.dotStateList = frag1.dotStateList | frag2.dotStateList

        return frag
    end
end