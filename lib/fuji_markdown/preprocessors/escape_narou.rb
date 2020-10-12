# frozen_string_literal: true

module FujiMarkdown
  module Preprocessors
    class EscapeNarou
      def call(text)
        text.gsub(/([一-龠々])（([\p{Hiragana}\p{Katakana}]+)）/, '\1|（\2）')
            .gsub(/([一-龠々])\(([\p{Hiragana}\p{Katakana}]+)\)/, '\1|(\2)')
            .gsub(/《([\p{Hiragana}\p{Katakana}]+)》/, '|《\1》')
      end
    end
  end
end
