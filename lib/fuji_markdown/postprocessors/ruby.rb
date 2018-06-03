module FujiMarkdown
  module Postprocessors
    class Ruby
      def initialize
        @ruby = false
      end

      def call(doc)
        doc.walk do |node|
          if node.type == :inline_html
            process_ruby_node!(node)
          end
        end
      end

      private

      def process_ruby_node!(node)
        case node.string_content
        when '<ruby>'
          @ruby = true
          node.delete
        when '</ruby>'
          @ruby = false
          node.delete
        when '<rt>'
          kanji_node = node.previous
          kana_node = node.next
          if @ruby && kana_node.next.string_content == '</rt>'
            convert_to_kakuyomu_ruby!(kanji_node, kana_node)
          end
          node.delete
        when '</rt>'
          node.delete
        else
          # do nothing
        end
      end

      def convert_to_kakuyomu_ruby!(kanji_node, kana_node)
        kanji_node.string_content = "|#{kanji_node.string_content}" if kanji_node.type == :text
        kana_node.string_content = "《#{kana_node.string_content}》" if kana_node.type == :text
      end
    end
  end
end
