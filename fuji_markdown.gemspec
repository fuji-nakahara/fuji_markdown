
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'fuji_markdown/version'

Gem::Specification.new do |spec|
  spec.name          = 'fuji_markdown'
  spec.version       = FujiMarkdown::VERSION
  spec.authors       = ['Fuji Nakahara']
  spec.email         = ['fujinakahara2032@gmail.com']

  spec.summary       = 'Markdown processor for Japanese novels'
  spec.description   = 'FujiMarkdown is the dialect of Markdown supporting extensions for Japanese novels.'
  spec.homepage      = 'https://github.com/fuji-nakahara/fuji_markdown'
  spec.license       = 'MIT'

  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = 'exe'
  spec.executables   = ['fujimd']
  spec.require_paths = ['lib']

  spec.add_dependency 'commonmarker', '~> 0.17'
  spec.add_development_dependency 'bundler', '~> 1.16'
  spec.add_development_dependency 'meowcop', '~> 1.16'
  spec.add_development_dependency 'pry'
  spec.add_development_dependency 'rake', '~> 12.3'
  spec.add_development_dependency 'rspec', '~> 3.7'
end
