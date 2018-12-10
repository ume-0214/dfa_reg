# dfa_reg
Deterministic Finite Automatonを用いた正規表現エンジンで、一致する部分文字列の長さを求めるプログラムです。

## 正規表現とリテラル

対応している正規表現とリテラルは以下のとおりです。  

* 正規表現
  * ',', '*', '?'
* リテラル
  * 'a-z'

## 入力例

    $ ruby main.rb
    abcdef
    def
    3

    $ ruby main.rb
    aaabbbcccddd
    c*
    3

## 参考文献
新屋良磨・鈴木勇介・高田謙（2015）「正規表現技術入門――最新エンジン実装と理論的背景」（WEB+DB PRESS plus）技術評論社.
