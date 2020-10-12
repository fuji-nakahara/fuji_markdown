require_relative 'lib/fuji_markdown/version'

Gem::Specification.new do |spec|
  spec.name          = 'fuji_markdown'
  spec.version       = FujiMarkdown::VERSION
  spec.authors       = ['Fuji Nakahara']
  spec.email         = ['fujinakahara2032@gmail.com']

  spec.summary       = 'Markdown processor for Japanese novels'
  spec.description   = 'FujiMarkdown is the dialect of Markdown supporting extensions for Japanese novels.'
  spec.homepage      = 'https://github.com/fuji-nakahara/fuji_markdown'
  spec.license       = 'MIT'
  spec.required_ruby_version = Gem::Requirement.new('>= 2.6')

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = 'https://github.com/fuji-nakahara/fuji_markdown'
  spec.metadata['changelog_uri'] = 'https://github.com/fuji-nakahara/fuji_markdown/blob/master/CHANGELOG.md'

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency 'commonmarker', '~> 0.17'
end
