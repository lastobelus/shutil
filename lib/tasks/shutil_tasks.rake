require 'shutil/cli'

namespace :shutil do
  desc "Smoke test for shopify apps. Uses a sidekiq worker to fetch product count, and checks for it in the sidekiq status. Expects"
  task :smoke, [:smoke_environment] => :environment do |t, args|

    puts "args: #{args.inspect}"

    smoke_environment = args[:smoke_environment] || ENV.fetch('SMOKE_ENVIRONMENT', nil)

    Shutil::CLI.exit_with_error(
      "call with `rails shutil:smoke[ENVIRONMENT] where ENVIRONMENT is one of production, staging"
    ) unless %w(production staging development).include?(smoke_environment)

    heroku_app = Shutil::Figaro.require_config! smoke_environment, 'HEROKU_APP'
    smoke_shop_id = Shutil::Figaro.require_config! smoke_environment, 'SMOKE_SHOP_ID'


    heroku = Shutil::Heroku.new(app: heroku_app)
    jid = heroku.run "SMOKE_SHOP_ID=#{smoke_shop_id} rails shutil:smoke_sidekiq"

    puts "jid: #{jid}"
  end

  task :smoke_sidekiq => :environment do
    shop_id = ENV.fetch('SMOKE_SHOP_ID')
    jid = Shutil::Sidekiq::Utilities::HelloWorldWorker.perform_async(shop_id)
    puts jid
  end

end


# rails tasks provide no namespacing by themselves
module Shutil
  module Figaro
    extend self

    def environments
      ::Figaro.application.send(:raw_configuration).keys
    end

    def [](figaro_env)
      Shutil::CLI.exit_with_exception(
        "no #{figaro_env} environment defined in config/application.yml"
      ) unless environments.include?(figaro_env.to_s)
      @configs ||= {}
      unless @configs[figaro_env.to_sym]
        config = ::Figaro::Rails::Application.new(environment: figaro_env.to_s)
        config.load
        @configs[figaro_env.to_sym] = config.configuration
      end
      @configs[figaro_env.to_sym]
    end

    def require_config!(figaro_env, key)
      config = self[figaro_env][key]
      Shutil::CLI.exit_with_error(
        "#{key} is not defined for #{figaro_env} in config/application.yml"
      ) unless config.present?
      config
    end
  end

  class Heroku
    vattr_initialize [:app]

    def debug
      ENV['DEBUG_SHUTIL']
    end

    def run(cmd)
      shcmd = "heroku run #{cmd} --app #{app}"
      if debug
        puts shcmd
      else
        `#{shcmd}`
      end
    end
  end
end