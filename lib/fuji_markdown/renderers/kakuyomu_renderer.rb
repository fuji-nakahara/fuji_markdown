require 'commonmarker'

module FujiMarkdown
  module Renderers
    class KakuyomuRenderer < CommonMarker::HtmlRenderer
      def header(node)
        out("\n") if node.previous&.type&.==(:paragraph)
        block do
          out('#' * node.header_level, ' ', :children)
        end
        out("\n")
      end

      def paragraph(node)
        block do
          out(:children)
        end
      end

      def hrule(_)
        out("\n")
      end

      def code_block(node)
        out("\n") if node.previous&.type&.==(:paragraph)
        block do
          out(escape_html(node.string_content))
        end
        out("\n")
      end

      def emph(_)
        out('《《', :children, '》》')
      end

      def link(node)
        out(:children)
      end

      def code(node)
        out('`')
        out(escape_html(node.string_content))
        out('`')
      end

      def softbreak(_)
        out("\n")
      end
    end
  end
end
