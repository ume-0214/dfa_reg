#!/usr/bin/env ruby
# coding: utf-8

$:.push(File.dirname(File.expand_path(__FILE__)))

# 状態管理クラス
class Context
    def initialize()
        @count = 0
    end

    # 状態の新規作成
    def newState()
        @count += 1

        return @count
    end
end