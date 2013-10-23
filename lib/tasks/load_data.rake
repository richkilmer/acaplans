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
    CSV.foreach("#{Rails.root}/data/us_states.csv", :headers => true) do |line|
      state_abbr[line[1]] = line[2]
    end
    
    FipsCode = Struct.new(:state, :county, :code)
    puts "Loading reference data..."
    fips_codes = []
    CSV.foreach("#{Rails.root}/data/us_fips_codes.csv", :headers => true) do |line|
      fips_codes << FipsCode.new(state_abbr[line[0]], line[1].upcase, (line[2]+line[3]).to_i)
    end
    
    def fips_codes.for(state, county)
      state = state.upcase
      county = county.upcase
      fips_code = detect { |fips_code| fips_code.state == state && fips_code.county == county }
      if fips_code
        fips_code.code
      else
        raise "We have no fips code for #{state} / #{county}"
      end
    end

    puts "Loading ACA plan data..."
    
    Plan.delete_all
    
    CSV.foreach("#{Rails.root}/data/QHP_Individual_Medical_Landscape.csv", :headers => true) do |line|
      
      state = line[0]
      county = line[1]
      
      Plan.create! fips:fips_codes.for(state, county), state:state, county:county
      
    end
    
    
    
  end
  
end