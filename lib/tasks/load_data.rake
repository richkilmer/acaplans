require 'csv'
namespace :db do

  desc "Load the database from the data files"
  task :load => :environment do
    Plan.delete_all
    Zip.delete_all
    CSV.foreach("#{Rails.root}/data/zip_county.csv", :headers => true) do |line|
      Zip.create! code:line[0], fips:line[1]
    end
  end
  
end