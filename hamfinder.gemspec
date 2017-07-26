# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'hamfinder/version'

Gem::Specification.new do |spec|
  spec.name          = "hamfinder"
  spec.version       = Hamfinder::VERSION
  spec.authors       = ["Jason Allen"]
  spec.email         = ["jasoncaryallen@gmail.com"]

  spec.summary       = %q{Return queried HAM radio repeater stations}
  spec.description   = %q{Querying Repeaterbook.com's data using application-defined criteria, this gem returns a collection of repeaters matching the criteria as JSON - conveniently sorted by proximity!}
  spec.homepage      = "https://github.com/jasonallenphotography/HAMfinder_gem"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "https://rubygems.org"
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency('json', '~> 2.1', '>= 2.1.0')
  spec.add_dependency('nokogiri', '~> 1.8', '>= 1.8.0')
  spec.add_development_dependency "bundler", "~> 1.13"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.6"
end
