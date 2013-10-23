class Plan < ActiveRecord::Base

  Levels = {
    "Bronze" => 0,
    "Silver" => 1,
    "Gold" => 2,
    "Platinum" => 3,
    "Catastrophic" => 4
  }

  validates :fips, presence: true 
end
