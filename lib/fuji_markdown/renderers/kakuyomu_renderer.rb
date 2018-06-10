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

      def emph(_)
        out('《《', :children, '》》')
      end

      def softbreak(_)
        out("\n")
      end
    end
  end
end
