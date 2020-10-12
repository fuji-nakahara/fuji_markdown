# frozen_string_literal: true

module FujiMarkdown
  module Postprocessors
    class Ruby
      KANJI_REGEXP = /\A[一-龠々]+\z/.freeze

      def initialize(omit_start_symbol: false)
        @ruby              = false
        @omit_start_symbol = omit_start_symbol
      end

      def call(doc)
        doc.walk do |node|
          process_ruby_node!(node) if node.type == :inline_html
        end
      end

      private

      def process_ruby_node!(node) # rubocop:disable Metrics/MethodLength
        case node.string_content
        when '<ruby>'
          @ruby = true
          node.delete
        when '</ruby>'
          @ruby = false
          node.delete
        when '<rt>'
          kanji_node = node.previous
          kana_node  = node.next
          convert_to_kakuyomu_ruby!(kanji_node, kana_node) if @ruby && kana_node.next.string_content == '</rt>'
          node.delete
        when '</rt>'
          node.delete
        end
      end

      def convert_to_kakuyomu_ruby!(kanji_node, kana_node)
        if kanji_node.type == :text && !(@omit_start_symbol && start_symbol_omittable?(kanji_node))
          kanji_node.string_content = "|#{kanji_node.string_content}"
        end
        kana_node.string_content = "《#{kana_node.string_content}》" if kana_node.type == :text
      end

      def start_symbol_omittable?(kanji_node)
        kanji_node.string_content.match?(KANJI_REGEXP) && !kanji_node.previous.string_content[-1].match?(KANJI_REGEXP)
      end
    end
  end
end
