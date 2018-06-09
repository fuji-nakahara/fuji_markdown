RSpec.describe FujiMarkdown::Postprocessors::Ruby do
  let(:doc) { FujiMarkdown.parse('冴えない{彼女|ヒロイン}は{紅蓮の炎|ヘルフレイム}を{学習|がく|しゅう}した！') }

  context 'without options' do
    subject { described_class.new }

    it 'replaces `ruby` elements with Kakuyomu kihou' do
      subject.call(doc)

      results = ''
      doc.walk do |node|
        if node.type == :text
          results << node.string_content
        end
      end
      expect(results).to eq '冴えない|彼女《ヒロイン》は|紅蓮の炎《ヘルフレイム》を|学《がく》|習《しゅう》した！'
    end
  end

  context 'with omit_start_symbol option' do
    subject { described_class.new(omit_start_symbol: true) }

    it 'replaces `ruby` elements with Kakuyomu kihou and omits start symbol if possible' do
      subject.call(doc)

      results = ''
      doc.walk do |node|
        if node.type == :text
          results << node.string_content
        end
      end
      expect(results).to eq '冴えない彼女《ヒロイン》は|紅蓮の炎《ヘルフレイム》を学《がく》習《しゅう》した！'
    end
  end
end
