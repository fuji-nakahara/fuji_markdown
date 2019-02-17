module FujiMarkdown
  module Preprocessors
    class Ruby
      RUBY_PATTERN = %r((?<!\\){(?<kanji>.*?)\|(?<kana>.*?)}).freeze

      def call(text)
        text.gsub!(RUBY_PATTERN) do |str|
          kanji, *kanas = str[/\A{(.*)}\z/, 1].split('|')
          return "<ruby>#{kanji}<rt></rt></ruby>" if kanas.empty?

          pairs = []
          kanas.each_with_index do |kana, i|
            if i == kanas.size - 1
              pairs << [kanji[i..-1], kana]
            else
              pairs << [kanji[i], kana]
            end
          end

          "<ruby>#{pairs.map { |k, kana| "#{k}<rt>#{kana}</rt>" }.join}</ruby>"
        end
      end
    end
  end
end
