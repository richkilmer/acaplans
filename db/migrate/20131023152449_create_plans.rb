class CreatePlans < ActiveRecord::Migration
  def change
    create_table :plans do |t|
      t.integer :fips
      t.string :state
      t.string :county
      t.integer :level
      t.string :issuer
      t.string :name
      t.string :plan_type
      t.string :rating_area
      t.decimal :premium_adult_individual_27, :precision => 8, :scale => 2
      t.decimal :premium_adult_individual_50, :precision => 8, :scale => 2
      t.decimal :premium_family, :precision => 8, :scale => 2
      t.decimal :premium_single_parent_family, :precision => 8, :scale => 2
      t.decimal :premium_couple, :precision => 8, :scale => 2
      t.decimal :premium_child, :precision => 8, :scale => 2

      t.timestamps
    end
    add_index :plans, :fips
  end
end
