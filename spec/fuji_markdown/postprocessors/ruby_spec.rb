# frozen_string_literal: true

RSpec.describe FujiMarkdown::Postprocessors::Ruby do
  let(:doc) { FujiMarkdown.parse('冴えない{彼女|ヒロイン}は{紅蓮の炎|ヘルフレイム}を{学習|がく|しゅう}した！') }

  context 'without options' do
    let(:options) { {} }

    it 'replaces `ruby` elements with Kakuyomu kihou' do
      described_class.new(options).call(doc)

      results = ''
      doc.walk do |node|
        results += node.string_content if node.type == :text
      end
      expect(results).to eq '冴えない|彼女《ヒロイン》は|紅蓮の炎《ヘルフレイム》を|学《がく》|習《しゅう》した！'
    end
  end

  context 'with omit_start_symbol option' do
    let(:options) { { omit_start_symbol: true } }

    it 'replaces `ruby` elements with Kakuyomu kihou and omits start symbol if possible' do
      described_class.new(options).call(doc)

      results = ''
      doc.walk do |node|
        results += node.string_content if node.type == :text
      end
      expect(results).to eq '冴えない彼女《ヒロイン》は|紅蓮の炎《ヘルフレイム》を学《がく》習《しゅう》した！'
    end
  end
end
