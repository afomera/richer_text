require_relative "lib/richer_text/version"

Gem::Specification.new do |spec|
  spec.name        = "richer_text"
  spec.version     = RicherText::VERSION
  spec.authors     = ["Andrea Fomera"]
  spec.email       = ["afomera@hey.com"]
  spec.homepage    = "https://github.com/afomera/richer_text"
  spec.summary     = "A richer text editor for Rails"
  # spec.description = "TODO: Description of RicherText."
  spec.license     = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the "allowed_push_host"
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  # spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"

  spec.metadata["homepage_uri"] = spec.homepage
  # spec.metadata["source_code_uri"] = "TODO: Put your gem's public repo URL here."
  # spec.metadata["changelog_uri"] = "TODO: Put your gem's CHANGELOG.md URL here."

  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]
  end

  spec.add_dependency "rails", "> 7.0.0"
  spec.add_dependency "ruby-oembed"
end
