# frozen_string_literal: true

RSpec.describe FujiMarkdown do
  describe '.parse' do
    let(:text) { 'こんにちは{世界|せかい}' }

    it 'converts FujiMarkdown into AST' do
      doc = described_class.parse(text)

      expected_node_types = %i[document paragraph text inline_html text inline_html text inline_html inline_html]
      doc.walk do |node|
        expect(node.type).to be expected_node_types.shift
      end
    end
  end

  describe '.render' do
    let(:text) do
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

    context 'with :HTML' do
      let(:preset) { :HTML }

      it 'converts FujiMarkdown into HTML' do
        result = described_class.render(text, preset)

        expect(result).to eq <<~'HTML'
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

    context 'with :KAKUYOMU' do
      let(:preset) { :KAKUYOMU }

      it 'converts FujiMarkdown into Kakuyomu text' do
        result = described_class.render(text, preset)

        expect(result).to eq <<~'TEXT'
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
      let(:preset) { :NAROU }

      it 'converts FujiMarkdown into Narou text' do
        result = described_class.render(text, preset)

        expect(result).to eq <<~'TEXT'
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
