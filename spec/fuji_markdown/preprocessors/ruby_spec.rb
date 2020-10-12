# frozen_string_literal: true

RSpec.describe FujiMarkdown::Preprocessors::Ruby do
  subject(:ruby) { described_class.new.call(text) }

  context 'with "{漢字|かんじ}"' do
    let(:text) { '{漢字|かんじ}' }

    it { is_expected.to eq '<ruby>漢字<rt>かんじ</rt></ruby>' }
  end

  context 'with "{漢字|かん|じ}"' do
    let(:text) { '{漢字|かん|じ}' }

    it { is_expected.to eq '<ruby>漢<rt>かん</rt>字<rt>じ</rt></ruby>' }
  end

  context 'with "{振仮名余|ふり|が|な|あま|り}"' do
    let(:text) { '{振仮名余|ふり|が|な|あま|り}' }

    it { is_expected.to eq '<ruby>振<rt>ふり</rt>仮<rt>が</rt>名<rt>な</rt>余<rt>あま</rt><rt>り</rt></ruby>' }
  end

  context 'with "{漢字余|かん|じあまり}"' do
    let(:text) { '{漢字余|かん|じあまり}' }

    it { is_expected.to eq '<ruby>漢<rt>かん</rt>字余<rt>じあまり</rt></ruby>' }
  end

  context 'with "\{漢字|かんじ}"' do
    let(:text) { '\{漢字|かんじ}' }

    it { is_expected.to eq '\{漢字|かんじ}' }
  end
end
