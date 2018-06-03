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
    let(:input) do
      <<~'MARKDOWN'
        # タイトル

        ## 第一章

        　これは段落である。
        「ここは会話だ」と{小鳥遊|たかなし}はいった。

        　これは二つ目の段落である。

        ## 第二章

        　*強調*も使えるし、《二重山括弧》も使える。
      MARKDOWN
    end

    context 'with :HTML option' do
      it 'converts FujiMarkdown into HTML' do
        expect(subject.render(input, :HTML)).to eq <<~'HTML'
          <h1>タイトル</h1>
          <h2>第一章</h2>
          <p>　これは段落である。<br />
          「ここは会話だ」と<ruby>小鳥遊<rt>たかなし</rt></ruby>はいった。</p>
          <p>　これは二つ目の段落である。</p>
          <h2>第二章</h2>
          <p>　<em>強調</em>も使えるし、《二重山括弧》も使える。</p>
        HTML
      end
    end

    context 'with :KAKUYOMU option' do
      it 'converts FujiMarkdown into Kakuyomu text' do
        expect(subject.render(input, :KAKUYOMU)).to eq <<~'TEXT'
          # タイトル

          ## 第一章
  
          　これは段落である。
          「ここは会話だ」と|小鳥遊《たかなし》はいった。
          　これは二つ目の段落である。

          ## 第二章

          　《《強調》》も使えるし、|《二重山括弧》も使える。
        TEXT
      end
    end
  end
end
