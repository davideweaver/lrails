# -*- encoding: utf-8 -*-
require File.expand_path('../lib/loggr/version', __FILE__)

Gem::Specification.new do |gem|
  gem.name = %q{loggr}
  gem.version = Loggr::VERSION
  gem.authors = ["Contrast"]
  gem.summary = %q{ getloggr.com is a hosted service for tracking errors in your Ruby/Rails/Rack apps }
  gem.description = %q{Loggr is the Ruby gem for communicating with http://loggr.net (hosted logging service). Use it to find out about errors that happen in your live app. It captures lots of helpful information to help you fix the errors.}
  gem.email = %q{hello@contrast.ie}
  gem.files =  Dir['lib/**/*'] + Dir['spec/**/*'] + Dir['spec/**/*'] + Dir['rails/**/*'] + Dir['tasks/**/*'] + Dir['*.rb'] + ["loggr.gemspec"]
  gem.homepage = %q{http://loggr.net/}
  gem.require_paths = ["lib"]
  gem.executables << 'loggr'
  gem.rubyforge_project = %q{loggr}
  gem.requirements << "json_pure, json-jruby or json gem required"
  gem.add_dependency 'rack'
end
