
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "linkedin_v2/version"

Gem::Specification.new do |spec|
  spec.name          = "linkedin_v2"
  spec.version       = LinkedinV2::VERSION
  spec.authors       = [ "Lucas Teles" ]
  spec.email         = [ "lucasteles22@gmail.com" ]

  spec.summary       = %q{Ruby wrapper for the LinkedIn API V2}
  spec.description   = %q{This gem interfaces with the LinkedIn REST API V2}
  spec.homepage      = "https://github.com/rockcontent/linkedin-api-v2"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)

    spec.metadata["homepage_uri"] = spec.homepage
    spec.metadata["wiki_uri"] = "https://github.com/rockcontent/linkedin-api-v2/wiki"
    spec.metadata["changelog_uri"] = "https://github.com/rockcontent/linkedin-api-v2/releases"
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = [ "lib" ]

  spec.add_dependency "rest-client", "~> 2.0", ">= 2.0.2"
  spec.add_dependency "down", "~> 4.8", ">= 4.8.1"

  spec.add_development_dependency "bundler", "~> 2.0"
  spec.add_development_dependency "rake", "~> 13.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "reek", "~> 5.4"
  spec.add_development_dependency "rubocop", "~> 0.73.0"
  spec.add_development_dependency "pry", "~> 0.12.2"
  spec.add_development_dependency "webmock", "~> 3.6"
  spec.add_development_dependency "vcr", "~> 5.0"
  spec.add_development_dependency "coveralls", "~> 0.8.23"
end
