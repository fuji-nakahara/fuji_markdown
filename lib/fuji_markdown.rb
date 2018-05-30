require_relative 'fuji_markdown/version'

require 'commonmarker'

module FujiMarkdown
  def self.render(text)
    CommonMarker.render_html(text)
  end
end
