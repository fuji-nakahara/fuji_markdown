RSpec.describe FujiMarkdown do
  subject { FujiMarkdown }

  describe '.parse' do
    it 'converts FujiMarkdown into AST' do
      input = 'こんにちは{世界|せかい}'
      output_node_types = %i[document paragraph text inline_html text inline_html text inline_html inline_html]

      subject.parse(input).walk do |node|
        expect(node.type).to be output_node_types.shift
      end
    end
  end

  describe '.render' do
    it 'converts FujiMarkdown into HTML' do
      input = <<~'MARKDOWN'
        # タイトル

        ## 第一章

        　これは段落である。
        「ここは会話だ」と{小鳥遊|たかなし}はいった。
      MARKDOWN

      output = <<~'HTML'
        <h1>タイトル</h1>
        <h2>第一章</h2>
        <p>　これは段落である。<br />
        「ここは会話だ」と<ruby>小鳥遊<rt>たかなし</rt></ruby>はいった。</p>
      HTML

      expect(subject.render(input)).to eq output
    end
  end
end
