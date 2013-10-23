require 'csv'
namespace :db do
  
  desc "Load the zipcodes from the data files"
  task :load_zipcodes => :environment do
    Zip.delete_all
    puts "Loading Zip code lookup data..."
    CSV.foreach("#{Rails.root}/data/zip_county.csv", :headers => true) do |line|
      Zip.create! code:line[0], fips:line[1]
    end
  end
  

  desc "Load the aca data from the data files"
  task :load_aca => :environment do
    state_abbr = {}
    CSV.foreach("#{Rails.root}/data/us_states.csv") do |line|
      state_abbr[line[1]] = line[2]
    end
    
    FipsCode = Struct.new(:state, :county, :code)
    puts "Loading reference data..."
    fips_codes = []
    CSV.foreach("#{Rails.root}/data/us_fips_codes.csv", :headers => true) do |line|
      state = state_abbr[line[0]]
      puts line unless state
      fips_codes << FipsCode.new(state, line[1].upcase, (line[2]+line[3]).to_i)
    end
    
    def fips_codes.for(state, county)
      state = state.upcase
      county = county.upcase
      fips_code = detect { |fips_code| fips_code.state == state && fips_code.county == county }
      fips_code ? fips_code.code : nil
    end
    
=begin
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
=end

    class String
      def undollar
        to_s[1..-1]
      end
    end
    
    class NilClass
      def undollar
        nil
      end
    end
    
    Plan.delete_all
    
    errors = []
    
    count = File.readlines("#{Rails.root}/data/QHP_Individual_Medical_Landscape.csv").size - 1
    
    puts "Loading #{count} ACA plans..."
    
    i = 0

    CSV.foreach("#{Rails.root}/data/QHP_Individual_Medical_Landscape.csv", :headers => true) do |line|
      i+=1
      if i%100 == 0
        puts "Loaded #{i} plans..."
      end

      begin

        state = line[0]
        county = line[1]
        fips = fips_codes.for(state, county)
        level = Plan::Levels[line[2]]
        raise "hell" unless level
        issuer = line[3]
        name = line[4]
        plan_type = line[5]
        rating_area = line[6]
        premium_adult_individual_27 = line[7].undollar
        premium_adult_individual_50 = line[8].undollar
        premium_family = line[9].undollar
        premium_single_parent_family = line[10].undollar
        premium_couple = line[11].undollar
        premium_child = line[12].undollar
      
        errors << "#{state}/#{county}" unless fips
        Plan.create fips:fips, state:state, county:county, level:level, issuer:issuer, 
                    name:name, plan_type:plan_type, rating_area:rating_area,
                    premium_adult_individual_27:premium_adult_individual_27,
                    premium_adult_individual_50:premium_adult_individual_50,
                    premium_family:premium_family,
                    premium_single_parent_family:premium_single_parent_family,
                    premium_couple:premium_couple,
                    premium_child:premium_child
      rescue
        puts "Error processing: #{i-1} / #{line}"
      end
                  
    end
    puts "Counties with errors:"
    puts errors.uniq
    
  end
  
end