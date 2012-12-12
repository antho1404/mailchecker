# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'mailchecker/version'

Gem::Specification.new do |gem|
  gem.name          = "mailchecker"
  gem.version       = Mailchecker::VERSION
  gem.authors       = ["antho1404"]
  gem.email         = ["contact@anthonyestebe.com"]
  gem.description   = %q{This will validate your email using mail-checker.com web service, it will test for you the format, if the domain responds and if the email is not a temporary mail}
  gem.summary       = %q{The easiest way to validate your emails !}
  gem.homepage      = "http://www.mail-checker.com/"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]
end
