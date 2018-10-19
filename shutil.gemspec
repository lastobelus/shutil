$:.push File.expand_path("lib", __dir__)

# Maintain your gem's version:
require "shutil/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name = "shutil"
  s.version = Shutil::VERSION
  s.authors = ["Michael Johnston"]
  s.email = ["lastobelus@mac.com"]
  s.summary = %q{Utilities for Shopify Rails Application}
  s.description = %q{This gem is a miscellaneous grab bag of things I've re-used in multiple shopify apps. Some items may eventually move to their own gems over time.'}
  s.homepage = "https://github.com/lastobelus/shutil"
  s.license = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  s.add_dependency "rails", ">= 5.1"

  ############################################################################
  # Background Jobs
  ############################################################################
  s.add_dependency "sidekiq"
  s.add_dependency "sidekiq-pro"
  s.add_dependency "sidekiq-status"                # allows workers that communicate status
  s.add_dependency "sinatra"
  s.add_dependency "sidekiq-failures"              # allows drilling down in failures for more info
  s.add_dependency "sidekiq-history"
  s.add_dependency "redis-rails"

  ############################################################################
  # APIS
  ############################################################################
  s.add_dependency "http"

  ############################################################################
  # ActiveRecord
  ############################################################################
  s.add_dependency "attr_extras"
  # Settings in json column
  s.add_dependency "jsonb_accessor"
  s.add_dependency "postgresql_cursor"
  
  ############################################################################
  # Deployment
  ############################################################################
  # configuration by ENV var
  s.add_dependency "figaro"
  s.add_dependency "rack-timeout"
  # heroku ruby metrics beta
  s.add_dependency "barnes"

  s.add_dependency "thor"

  ############################################################################
  # CSV Import
  ############################################################################
  s.add_dependency "smarter_csv"
  s.add_dependency "roo"
  s.add_dependency "roo-xls"

  s.add_development_dependency "sqlite3"
end
