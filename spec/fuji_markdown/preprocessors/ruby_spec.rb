RSpec.describe FujiMarkdown::Preprocessors::Ruby do
  subject { described_class.new }

  it { expect(subject.call('{漢字|かんじ}')).to eq '<ruby>漢字<rt>かんじ</rt></ruby>' }
  it { expect(subject.call('{漢字|かん|じ}')).to eq '<ruby>漢<rt>かん</rt>字<rt>じ</rt></ruby>'}
  it { expect(subject.call('{振仮名余|ふり|が|な|あま|り}')).to eq '<ruby>振<rt>ふり</rt>仮<rt>が</rt>名<rt>な</rt>余<rt>あま</rt><rt>り</rt></ruby>' }
  it { expect(subject.call('{漢字余|かん|じあまり}')).to eq '<ruby>漢<rt>かん</rt>字余<rt>じあまり</rt></ruby>' }
end
