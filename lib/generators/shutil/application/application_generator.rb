class Shutil::ApplicationGenerator < Rails::Generators::Base
  source_root File.expand_path("templates", __dir__)

  def controllers
    template "application_controller.rb", "app/controllers/application_controller.rb"
    template "home_controller.rb", "app/controllers/home_controller.rb"
    template "authenticated_by_shopify.rb", "app/controllers/concerns/shopify_app/authenticated_by_shopify.rb"
  end

  def views
    remove_file "app/views/home/index.html.erb"
    template "home/index.html.slim", "app/views/home/index.html.slim"
  end
end
