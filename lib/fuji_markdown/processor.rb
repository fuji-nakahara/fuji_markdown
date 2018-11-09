module FujiMarkdown
  class Processor
    attr_reader :preprocessors, :parser, :postprocessors, :renderer

    def initialize(preprocessors: [], parser: CommonMarker, postprocessors: [], renderer: CommonMarker::HtmlRenderer.new)
      @preprocessors  = preprocessors
      @parser         = parser
      @postprocessors = postprocessors
      @renderer       = renderer
    end

    def parse(text)
      processed_text = text.dup

      preprocessors.each do |preprocessor|
        preprocessor.call(processed_text)
      end

      parser.render_doc(processed_text)
    end

    def render(text)
      doc = parse(text)

      postprocessors.each do |postprocessor|
        postprocessor.call(doc)
      end

      renderer.render(doc)
    end
  end
end
