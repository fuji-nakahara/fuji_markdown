require_relative 'fuji_markdown/error'
require_relative 'fuji_markdown/processor'
require_relative 'fuji_markdown/postprocessors/ruby'
require_relative 'fuji_markdown/preprocessors/ruby'
require_relative 'fuji_markdown/preprocessors/escape_narou'
require_relative 'fuji_markdown/renderers/text_renderer'
require_relative 'fuji_markdown/renderers/kakuyomu_renderer'
require_relative 'fuji_markdown/renderers/narou_renderer'

module FujiMarkdown
  PRESETS = {
    HTML: {
      preprocessors: [Preprocessors::Ruby.new],
      renderer: CommonMarker::HtmlRenderer.new(options: %i[HARDBREAKS UNSAFE])
    },
    KAKUYOMU: {
      preprocessors: [Preprocessors::Ruby.new, proc { |text| text.gsub(/《/, '|《') }],
      postprocessors: [Postprocessors::Ruby.new],
      renderer: Renderers::KakuyomuRenderer.new
    },
    NAROU: {
      preprocessors: [Preprocessors::Ruby.new, Preprocessors::EscapeNarou.new],
      postprocessors: [Postprocessors::Ruby.new],
      renderer: Renderers::NarouRenderer.new
    }
  }.freeze

  class << self
    def parse(text, preset = :HTML)
      options = PRESETS.fetch(preset)
      Processor.new(**options).parse(text)
    rescue KeyError => e
      raise InvalidPresetError, "Invalid preset: #{e.key}"
    end

    def render(text, preset = :HTML)
      options = PRESETS.fetch(preset)
      Processor.new(**options).render(text)
    rescue KeyError => e
      raise InvalidPresetError, "Invalid preset: #{e.key}"
    end
  end
end
