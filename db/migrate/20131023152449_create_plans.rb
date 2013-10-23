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
      t.integer :premium_adult_individual_27
      t.integer :premium_adult_individual_50
      t.integer :premium_family
      t.integer :premium_single_parent_family
      t.integer :premium_couple
      t.integer :premium_child

      t.timestamps
    end
    add_index :plans, :fips
  end
end
