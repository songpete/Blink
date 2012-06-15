class CreateSites < ActiveRecord::Migration
  def change
    create_table :sites do |t|
      t.string :short_path
      t.string :destination
      t.integer :count

      t.timestamps
    end
  end
end
