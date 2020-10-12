RSpec.describe FujiMarkdown::Preprocessors::EscapeNarou do
  subject(:escape_narou) { described_class.new.call(text) }

  context 'with "漢字（かんじ）"' do
    let(:text) { '漢字（かんじ）' }

    it { is_expected.to eq '漢字|（かんじ）' }
  end

  context 'with "漢字(カンジ)"' do
    let(:text) { '漢字(カンジ)' }

    it { is_expected.to eq '漢字|(カンジ)' }
  end

  context 'with "《かんジ》"' do
    let(:text) { '《かんジ》' }

    it { is_expected.to eq '|《かんジ》' }
  end
end
