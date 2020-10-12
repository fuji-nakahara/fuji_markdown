require 'commonmarker'

module FujiMarkdown
  class Processor
    def initialize(preprocessors: [], postprocessors: [], renderer: CommonMarker::HtmlRenderer.new)
      @preprocessors  = preprocessors
      @postprocessors = postprocessors
      @renderer       = renderer
    end

    def parse(text)
      processed_text = @preprocessors.inject(text) do |result, preprocessor|
        preprocessor.call(result)
      end

      CommonMarker.render_doc(processed_text)
    end

    def render(text)
      doc = parse(text)

      @postprocessors.each do |postprocessor|
        postprocessor.call(doc)
      end

      @renderer.render(doc)
    end
  end
end
