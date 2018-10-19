class Shutil::CsvExportsGenerator < Rails::Generators::Base
  source_root File.expand_path("templates", __dir__)

  def resource
    route "resources :csv_exports, only: [:index, :show]"
    copy_file ".keep", "app/models/csv_exporters/.keep"
    copy_file "csv_exporters.rb", "app/models/csv_exporters.rb"
    directory "views", "app/views/csv_exports"
    copy_file "csv_exports_controller.rb", "app/controllers/csv_exports_controller.rb"
  end

  def menu
    directory "menus/app/items", "app/views/layouts/menus/app/items"
    append_to_file "app/views/layouts/menus/app/_menu_items.html.erb" do
      "<%= render 'layouts/menus/app/items/csv_exports' %>"
    end
  end
end
