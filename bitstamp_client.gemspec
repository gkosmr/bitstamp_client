Gem::Specification.new do |spec|
  spec.name          = 'bitstamp_client'
  spec.version       = File.read('VERSION.semver').chomp
  spec.authors       = ['']
  spec.email         = ['']
  spec.description   = %q{'Wrapper for BitStamp API'}
  spec.summary       = %q{'Wrapper for BitStamp API'}
  spec.homepage      = 'https://github.com/gkosmr/bitstamp_client'
  spec.license       = 'MIT'

  spec.files         =
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^test/}) }
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.10'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'spectus', '~> 2.3.1'
  spec.add_development_dependency 'pry'
  spec.add_development_dependency 'webmock'
  spec.add_development_dependency 'vcr'
  spec.add_development_dependency 'yard', '~> 0.8'
  spec.add_development_dependency 'simplecov', '~> 0.7.1'
  spec.add_development_dependency 'codeclimate-test-reporter'
  spec.add_development_dependency 'rubocop', '~> 0.34'

  spec.add_dependency 'httparty'
  spec.add_dependency 'hashie'
  spec.add_dependency 'addressabler'

  spec.add_runtime_dependency 'activesupport', '>= 3.2'
end
