# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'aws_pipes/version'

Gem::Specification.new do |gem|
  gem.name          = "aws_pipes"
  gem.version       = AwsPipes::VERSION
  gem.authors       = ["Joe Nelson"]
  gem.email         = ["cred+github@begriffs.com"]
  gem.description   = %q{TODO: Write a gem description}
  gem.summary       = %q{Amazon Web Services à la Unix}
  gem.homepage      = "https://github.com/begriffs/aws_pipes"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_dependency "aws-sdk-ruby"
  gem.add_dependency "trollop"
end
