require_relative 'fuji_markdown/version'

require 'commonmarker'

module FujiMarkdown
  def self.render(text)
    doc = CommonMarker.render_doc(text)
    doc.to_html(:HARDBREAKS)
  end
end
