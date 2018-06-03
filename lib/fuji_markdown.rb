require_relative 'fuji_markdown/version'

require_relative 'fuji_markdown/preprocessors/ruby'

require 'commonmarker'

module FujiMarkdown
  def self.parse(text)
    preprocessors = [Preprocessors::Ruby.new]

    processed_text = text.dup
    preprocessors.each do |filter|
      processed_text = filter.call(processed_text)
    end

    CommonMarker.render_doc(processed_text)
  end

  def self.render(text)
    doc = parse(text)
    doc.to_html(:HARDBREAKS)
  end
end
