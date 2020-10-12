# FujiMarkdown

FujiMarkdown is the dialect of Markdown supporting extensions for Japanese novels.  
This gem is built on [CommonMarker](https://github.com/gjtorikian/commonmarker), and inspired by [Mato](https://github.com/bitjourney/mato).

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'fuji_markdown'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install fuji_markdown

## Usage

```ruby
require 'fuji_markdown'

FujiMarkdown.render('山へ*柴刈り*に出かけたおじいさんは{紅蓮の炎|ヘルフレイム}に焼かれ果てた。')
# => "<p>山へ<em>柴刈り</em>に出かけたおじいさんは<ruby>紅蓮の炎<rt>ヘルフレイム</rt></ruby>に焼かれ果てた。</p>\n"

FujiMarkdown.render('山へ*柴刈り*に出かけたおじいさんは{紅蓮の炎|ヘルフレイム}に焼かれ果てた。', :KAKUYOMU)
# => "山へ《《柴刈り》》に出かけたおじいさんは|紅蓮の炎《ヘルフレイム》に焼かれ果てた。\n"

FujiMarkdown.render('山へ*柴刈り*に出かけたおじいさんは{紅蓮の炎|ヘルフレイム}に焼かれ果てた。', :NAROU)
# => "山へ|柴《・》|刈《・》|り《・》に出かけたおじいさんは|紅蓮の炎《ヘルフレイム》に焼かれ果てた。\n"
```

See [spec](spec/fuji_markdown_spec.rb) for more detail.

---

In addition, you can use `fujimd` command from CLI:

    $ fujimd your-FujiMarkdown-file.md [--output kakuyomu]

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/fuji-nakahara/fuji_markdown. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/fuji-nakahara/fuji_markdown/blob/master/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the FujiMarkdown project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/fuji-nakahara/fuji_markdown/blob/master/CODE_OF_CONDUCT.md).
