class CreateCsvImports < ActiveRecord::Migration[5.0]
  def change
    create_table :csv_imports do |t|
      t.binary :file_data
      t.string :processor
      t.references :shop, foreign_key: true
      t.string :info
      t.string :filename
      t.string :content_type
      t.string :state, default: "created"

      t.timestamp :started_processing_at
      t.timestamp :finished_processing_at

      t.timestamps
    end
  end
end
