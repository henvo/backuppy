
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "backuppy/version"

Gem::Specification.new do |spec|
  spec.name          = "backuppy"
  spec.version       = Backuppy::VERSION
  spec.authors       = ["Henning Vogt"]
  spec.email         = ["git@henvo.de"]

  spec.summary       = %q{Backups files sent via mail}
  spec.homepage      = "https://github.com/henvo/backuppy"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata["allowed_push_host"] = "https://rubygems.org"
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

  spec.add_dependency "mail", "~> 2.7"
  spec.add_dependency "logging", "~> 2.2"
  spec.add_dependency "thor", "~> 0.20"

  spec.add_development_dependency "bundler", "~> 1.16"
  spec.add_development_dependency "rake", "~> 10.0"
end
