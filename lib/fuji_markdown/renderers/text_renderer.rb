# frozen_string_literal: true

module FujiMarkdown
  module Renderers
    class TextRenderer < CommonMarker::HtmlRenderer
      def header(node)
        out("\n") if node.previous&.type&.==(:paragraph)
        block do
          out('#' * node.header_level, ' ', :children)
        end
        out("\n")
      end

      def paragraph(node)
        return out(:children) if node.parent.type == :blockquote

        block do
          out(:children)
        end
      end

      def blockquote(node)
        out("\n") if node.previous&.type&.==(:paragraph)
        block do
          out('> ', :children)
        end
        out("\n")
      end

      def hrule(_)
        out("\n")
      end

      def code_block(node)
        out("\n") if node.previous&.type&.==(:paragraph)
        out('```')
        block do
          out(escape_html(node.string_content))
        end
        out('```')
        out("\n")
      end

      def emph(_)
        out('*', :children, '*')
      end

      def link(node)
        out('[', :children, '](', node.url.nil? ? '' : escape_href(node.url), ')')
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
