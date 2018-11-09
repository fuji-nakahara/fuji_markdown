module FujiMarkdown
  module Renderers
    class NarouRenderer < TextRenderer
      def code_block(node)
        out("\n") if node.previous&.type&.==(:paragraph)
        block do
          out(escape_html(node.string_content))
        end
        out("\n")
      end

      def emph(node)
        node.walk do |n|
          if n.type == :text
            n.string_content = n.string_content.chars.map { |char| "|#{char}《・》"}.join
          end
        end
        out(:children)
      end

      def link(node)
        out(:children)
      end
    end
  end
end
