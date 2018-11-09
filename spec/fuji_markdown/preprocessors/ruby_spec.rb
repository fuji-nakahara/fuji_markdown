RSpec.describe FujiMarkdown::Preprocessors::Ruby do
  subject { described_class.new.call(text) }

  context 'with "{漢字|かんじ}"' do
    let(:text) { '{漢字|かんじ}' }

    it 'converts it into "<ruby>漢字<rt>かんじ</rt></ruby>"' do
      subject

      expect(text).to eq '<ruby>漢字<rt>かんじ</rt></ruby>'
    end
  end

  context 'with "{漢字|かん|じ}"' do
    let(:text) { '{漢字|かん|じ}' }

    it 'converts it into "<ruby>漢<rt>かん</rt>字<rt>じ</rt></ruby>"' do
      subject

      expect(text).to eq '<ruby>漢<rt>かん</rt>字<rt>じ</rt></ruby>'
    end
  end

  context 'with "{振仮名余|ふり|が|な|あま|り}"' do
    let(:text) { '{振仮名余|ふり|が|な|あま|り}' }

    it 'converts it into "<ruby>振<rt>ふり</rt>仮<rt>が</rt>名<rt>な</rt>余<rt>あま</rt><rt>り</rt></ruby>"' do
      subject

      expect(text).to eq '<ruby>振<rt>ふり</rt>仮<rt>が</rt>名<rt>な</rt>余<rt>あま</rt><rt>り</rt></ruby>'
    end
  end

  context 'with "{漢字余|かん|じあまり}"' do
    let(:text) { '{漢字余|かん|じあまり}' }

    it 'converts it into "<ruby>漢<rt>かん</rt>字余<rt>じあまり</rt></ruby>"' do
      subject

      expect(text).to eq '<ruby>漢<rt>かん</rt>字余<rt>じあまり</rt></ruby>'
    end
  end
end
