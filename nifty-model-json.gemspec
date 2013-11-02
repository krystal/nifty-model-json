require File.expand_path('../lib/nifty/model_json/version', __FILE__)

Gem::Specification.new do |s|
  s.name          = "nifty-model-json"
  s.description   = %q{A Rails extension for creating JSON hashes for Active Record classes}
  s.summary       = s.description
  s.homepage      = "https://github.com/niftyware/model-json"
  s.version       = Nifty::ModelJSON::VERSION
  s.files         = Dir.glob("{lib}/**/*")
  s.require_paths = ["lib"]
  s.authors       = ["Adam Cooke"]
  s.email         = ["adam@niftyware.io"]
  s.add_dependency "json"
end
