class Plan < ActiveRecord::Base

  Levels = {
    "Bronze" => 0,
    "Silver" => 1,
    "Gold" => 2,
    "Platinum" => 3,
    "Catastrophic" => 4
  }

  validates :fips, presence: true
  validates :level, presence: true

  def level_name
    Levels.invert[level]
  end
end
