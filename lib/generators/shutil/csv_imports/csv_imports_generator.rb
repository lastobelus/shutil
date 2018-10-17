class Shutil::CsvImportsGenerator < Rails::Generators::Base
  source_root File.expand_path("templates", __dir__)
  include Rails::Generators::Migration

  def self.next_migration_number(path)
    Time.now.utc.strftime("%Y%m%d%H%M%S%L")
  end

  def create_resource
    migration_template "migration.rb", "db/migrate/create_csv_imports.rb"
    directory "views", "app/views/csv_imports"
    copy_file "controller.rb", "app/controllers/csv_imports_controller.rb"
    copy_file "model.rb", "app/models/csv_import.rb"
    route "resources :csv_imports, only: [:index, :create, :show]"
    insert_into_file "app/models/shop.rb", "\n  has_many :csv_imports\n", after: "include Shops::AdminLinks\n"
  end

  def add_menu
    directory "menus/app/items", "app/views/layouts/menus/app/items"
    append_to_file "app/views/layouts/menus/app/_menu_items.html.erb" do
      "<%= render 'layouts/menus/app/items/csv_imports' %>"
    end
  end
end
