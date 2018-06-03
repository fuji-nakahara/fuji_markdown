module FujiMarkdown
  module Preprocessors
    class Ruby
      RUBY_PATTERN =
        %r(
            {
            (?<kanji>[^{}|]*)
            \|
            (?<kana>[^{}|]*)
            }
          )x

      def call(text)
        text.gsub!(RUBY_PATTERN) do |match|
          kanji, kana = match.slice(1...-1).split('|')
          "<ruby>#{kanji}<rt>#{kana}</rt></ruby>"
        end
      end
    end
  end
end
