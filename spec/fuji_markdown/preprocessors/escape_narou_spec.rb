RSpec.describe FujiMarkdown::Preprocessors::EscapeNarou do
  subject { described_class.new.call(text) }

  context 'with "漢字（かんじ）"' do
    let(:text) { '漢字（かんじ）' }

    it 'converts it into "漢字|（かんじ）"' do
      subject

      expect(text).to eq '漢字|（かんじ）'
    end
  end

  context 'with "漢字(カンジ)"' do
    let(:text) { '漢字(カンジ)' }

    it 'converts it into "漢字|(カンジ)"' do
      subject

      expect(text).to eq '漢字|(カンジ)'
    end
  end

  context 'with "《かんジ》"' do
    let(:text) { '《かんジ》' }

    it 'converts it into "|《かんジ》"' do
      subject

      expect(text).to eq '|《かんジ》'
    end
  end
end
