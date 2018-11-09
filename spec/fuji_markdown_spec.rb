RSpec.describe FujiMarkdown do
  describe '.parse' do
    subject { described_class.parse(input) }

    let(:input) { 'こんにちは{世界|せかい}' }

    it 'converts FujiMarkdown into AST' do
      output_node_types = %i[document paragraph text inline_html text inline_html text inline_html inline_html]

      subject.walk do |node|
        expect(node.type).to be output_node_types.shift
      end
    end
  end

  describe '.render' do
    subject { described_class.render(input, option) }

    let(:input) do
      <<~'MARKDOWN'
        # タイトル

        ## 第一章

        　これは{段落|だん|らく}である。
        「ここは会話だ」と{小鳥遊|たかなし}はいった。

        　これは二つ目の段落である。

        ## 第二章

        　*強調*も使えるし、《二重山括弧》も使える。[リンク](https://github.com/fuji-nakahara/fuji_markdown)も張れる。

        ---

        　場面転換した。

        > これは引用である。

        　また地の文に戻った。
      MARKDOWN
    end

    context 'with :HTML option' do
      let(:option) { :HTML }

      it 'converts FujiMarkdown into HTML' do
        expect(subject).to eq <<~'HTML'
          <h1>タイトル</h1>
          <h2>第一章</h2>
          <p>　これは<ruby>段<rt>だん</rt>落<rt>らく</rt></ruby>である。<br />
          「ここは会話だ」と<ruby>小鳥遊<rt>たかなし</rt></ruby>はいった。</p>
          <p>　これは二つ目の段落である。</p>
          <h2>第二章</h2>
          <p>　<em>強調</em>も使えるし、《二重山括弧》も使える。<a href="https://github.com/fuji-nakahara/fuji_markdown">リンク</a>も張れる。</p>
          <hr />
          <p>　場面転換した。</p>
          <blockquote>
          <p>これは引用である。</p>
          </blockquote>
          <p>　また地の文に戻った。</p>
        HTML
      end
    end

    context 'with :KAKUYOMU option' do
      let(:option) { :KAKUYOMU }

      it 'converts FujiMarkdown into Kakuyomu text' do
        expect(subject).to eq <<~'TEXT'
          # タイトル

          ## 第一章
  
          　これは|段《だん》|落《らく》である。
          「ここは会話だ」と|小鳥遊《たかなし》はいった。
          　これは二つ目の段落である。

          ## 第二章

          　《《強調》》も使えるし、|《二重山括弧》も使える。リンクも張れる。

          　場面転換した。

          > これは引用である。

          　また地の文に戻った。
        TEXT
      end
    end

    context 'with :NAROU option' do
      let(:option) { :NAROU }

      it 'converts FujiMarkdown into Narou text' do
        expect(subject).to eq <<~'TEXT'
          # タイトル

          ## 第一章
  
          　これは|段《だん》|落《らく》である。
          「ここは会話だ」と|小鳥遊《たかなし》はいった。
          　これは二つ目の段落である。

          ## 第二章

          　|強《・》|調《・》も使えるし、《二重山括弧》も使える。リンクも張れる。

          　場面転換した。

          > これは引用である。

          　また地の文に戻った。
        TEXT
      end
    end
  end
end
