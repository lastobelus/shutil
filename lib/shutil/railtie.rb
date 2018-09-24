module Shutil
  class Railtie < ::Rails::Railtie
    initializer "shutil.initialize" do |app|
      puts "initializing shutil"
    end

    rake_tasks do
      load 'tasks/shutil_tasks.rake'
    end

  end
end
