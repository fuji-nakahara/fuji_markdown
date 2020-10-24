# frozen_string_literal: true

require_relative 'fuji_markdown/error'
require_relative 'fuji_markdown/processor'
require_relative 'fuji_markdown/postprocessors/ruby'
require_relative 'fuji_markdown/preprocessors/ruby'
require_relative 'fuji_markdown/preprocessors/escape_narou'
require_relative 'fuji_markdown/renderers/text_renderer'
require_relative 'fuji_markdown/renderers/kakuyomu_renderer'
require_relative 'fuji_markdown/renderers/narou_renderer'

module FujiMarkdown
  class << self
    def parse(text, preset = :HTML)
      options = build_options_from_preset(preset)
      Processor.new(**options).parse(text)
    end

    def render(text, preset = :HTML)
      options = build_options_from_preset(preset)
      Processor.new(**options).render(text)
    end

    private

    def build_options_from_preset(preset) # rubocop:disable Metrics/MethodLength
      case preset
      when :HTML
        {
          preprocessors: [Preprocessors::Ruby.new],
          renderer: CommonMarker::HtmlRenderer.new(options: %i[HARDBREAKS UNSAFE])
        }
      when :KAKUYOMU
        {
          preprocessors: [Preprocessors::Ruby.new, proc { |text| text.gsub(/《/, '|《') }],
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
        raise InvalidPresetError, "Invalid preset: #{preset}"
      end
    end
  end
end
