module FujiMarkdown
  module Renderers
    class KakuyomuRenderer < TextRenderer
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
    end
  end
end
