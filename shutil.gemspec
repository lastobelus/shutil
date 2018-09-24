$:.push File.expand_path("lib", __dir__)

# Maintain your gem's version:
require "shutil/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "shutil"
  s.version     = Shutil::VERSION
  s.authors     = ["Michael Johnston"]
  s.email       = ["lastobelus@mac.com"]
  s.homepage    = "TODO"
  s.summary     = "TODO: Summary of Shutil."
  s.description = "TODO: Description of Shutil."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  s.add_dependency "rails", "~> 5.2.1"

  s.add_development_dependency "sqlite3"
end
