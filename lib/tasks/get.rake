task :get_all => :environment do
  Sample.create_from_remote
end
