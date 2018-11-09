module FujiMarkdown
  module Preprocessors
    class EscapeNarou
      def call(text)
        text.gsub!(/([一-龠々])（([\p{Hiragana}\p{Katakana}]+)）/, '\1|（\2）')
        text.gsub!(/([一-龠々])\(([\p{Hiragana}\p{Katakana}]+)\)/, '\1|(\2)')
        text.gsub!(/《([\p{Hiragana}\p{Katakana}]+)》/, '|《\1》')
      end
    end
  end
end
