require 'commonmarker'

require_relative 'fuji_markdown/processor'
require_relative 'fuji_markdown/version'

require_relative 'fuji_markdown/postprocessors/ruby'
require_relative 'fuji_markdown/preprocessors/ruby'
require_relative 'fuji_markdown/preprocessors/escape_narou'
require_relative 'fuji_markdown/renderers/text_renderer'
require_relative 'fuji_markdown/renderers/kakuyomu_renderer'
require_relative 'fuji_markdown/renderers/narou_renderer'

module FujiMarkdown
  class << self
    def parse(text, option = :HTML)
      processor(option).parse(text)
    end

    def render(text, option = :HTML)
      processor(option).render(text)
    end

    private

    def processor(option)
      args = processor_args(option)
      Processor.new(args)
    end

    def processor_args(option)
      case option
      when :HTML
        {
          preprocessors: [Preprocessors::Ruby.new],
          renderer: CommonMarker::HtmlRenderer.new(options: %i[HARDBREAKS UNSAFE])
        }
      when :KAKUYOMU
        {
          preprocessors: [Preprocessors::Ruby.new, proc { |text| text.gsub!(/《/, '|《') }],
          postprocessors: [Postprocessors::Ruby.new],
          renderer: Renderers::KakuyomuRenderer.new
        }
      when :NAROU
        {
          preprocessors: [Preprocessors::Ruby.new, Preprocessors::EscapeNarou.new],
          postprocessors: [Postprocessors::Ruby.new],
          renderer: Renderers::NarouRenderer.new
        }
      else
        raise ArgumentError, "Invalid option #{option}"
      end
    end
  end
end
