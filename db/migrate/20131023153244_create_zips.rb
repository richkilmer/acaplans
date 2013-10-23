class CreateZips < ActiveRecord::Migration
  def change
    create_table :zips do |t|
      t.string  :code
      t.integer :fips

      t.timestamps
    end
    add_index :zips, :fips
  end
end
