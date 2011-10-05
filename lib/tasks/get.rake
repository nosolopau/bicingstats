task :get_all => :environment do
  Status.create_from_remote
end
