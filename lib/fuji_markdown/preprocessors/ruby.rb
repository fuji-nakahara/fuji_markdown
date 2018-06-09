module FujiMarkdown
  module Preprocessors
    class Ruby
      RUBY_PATTERN =
        %r(
            {
            (?<kanji>[^{}|]*)
            \|
            (?<kana>[^{}]*)
            }
          )x

      def call(text)
        text.gsub!(RUBY_PATTERN) do |match|
          kanji, *kanas = match.slice(1...-1).split('|')
          return "<ruby>#{kanji}<rt></rt></ruby>" if kanas.empty?

          pairs = []
          kanas.each_with_index do |kana, i|
            if i == kanas.size - 1
              pairs << [kanji.slice(i..-1), kana]
            else
              pairs << [kanji.slice(i), kana]
            end
          end

          "<ruby>#{pairs.map { |k, kana| "#{k}<rt>#{kana}</rt>" }.join}</ruby>"
        end
      end
    end
  end
end
