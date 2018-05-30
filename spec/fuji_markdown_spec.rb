RSpec.describe FujiMarkdown do
  subject { FujiMarkdown }

  describe '.render' do
    it 'converts fuji-markdown into HTML' do
      expect(subject.render('Hello world.')).to eq "<p>Hello world.</p>\n"
    end
  end
end
