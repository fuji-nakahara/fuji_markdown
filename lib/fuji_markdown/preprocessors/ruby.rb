module FujiMarkdown
  module Preprocessors
    class Ruby
      RUBY_REGEXP = /(?<!\\){(?<kanji>.*?)\|(?<kana>.*?)}/.freeze

      def call(text)
        text.gsub(RUBY_REGEXP) do |ruby_pattern|
          convert_to_html(ruby_pattern)
        end
      end

      private

      def convert_to_html(ruby_pattern)
        kanji_chars, *kanas = ruby_pattern[/\A{(.*)}\z/, 1].split('|')
        return "<ruby>#{kanji_chars}<rt></rt></ruby>" if kanas.empty?

        pairs = kanas.each_with_object([]).with_index do |(kana, arr), i|
          arr << if i == kanas.size - 1
                   [kanji_chars[i..], kana]
                 else
                   [kanji_chars[i], kana]
                 end
        end

        "<ruby>#{pairs.map { |kanji, kana| "#{kanji}<rt>#{kana}</rt>" }.join}</ruby>"
      end
    end
  end
end
