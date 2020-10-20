lib = File.expand_path("lib", __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "pdf_split/version"

Gem::Specification.new do |spec|
  spec.name          = "pdf_split"
  spec.version       = PdfSplit::VERSION
  spec.authors       = ["2019040946"]
  spec.email         = ["dingding819@naver.com"]

  spec.summary       = %q{It splits given PDF file}
  spec.description   = %q{It splits PDF file into single page pdf files.}
  spec.homepage      = "http://www.softwarelab.me"
  spec.license       = "MIT"

  spec.metadata["allowed_push_host"] = "Set to 'http://mygemserver.com'"

  spec.metadata["homepage_uri"] = spec.homepage
  # spec.metadata["source_code_uri"] = "'http://mygemserver.com'"
  # spec.metadata["changelog_uri"] = 

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 2.0"
  spec.add_development_dependency "rake", "~> 10.0"
end
