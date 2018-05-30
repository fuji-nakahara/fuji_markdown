require_relative 'fuji_markdown/version'

require_relative 'fuji_markdown/text_filters/ruby'

require 'commonmarker'

module FujiMarkdown
  def self.render(text)
    text_filters = [TextFilters::Ruby.new]

    filtered_text = text.dup
    text_filters.each do |filter|
      filtered_text = filter.call(filtered_text)
    end

    doc = CommonMarker.render_doc(filtered_text)
    doc.to_html(:HARDBREAKS)
  end
end
