namespace :db do
  desc "Erase and fill database"
  task :populate => :environment do
    require 'populator'
    require 'faker'
    

    [Category, User, Job].each(&:delete_all)

    Category.populate 10 do |category|
      category.name = Populator.words(1..2).titleize
      category.description = Populator.words(1..4).titleize
    end    
     
    Job.populate 40 do |job|
      job.title = Populator.words(1..2).titleize
      job.text = Populator.words(1..4).titleize
    end
    
    Job.all.map do |job|
      job.categories << Category.order("RANDOM()").first
      job.categories << Category.order("RANDOM()").first
      job.categories << Category.order("RANDOM()").first
      job.city_district_id = CityDistrict.order("RANDOM()").first.id
      job.save
    end    


    User.populate 20 do |user|
      user.name = Faker::Name.name
      user.email = Faker::Internet.email
      user.sign_in_count = 0
      user.encrypted_password = User.new(:password => "password").encrypted_password
    end

    User.all.map do |user|
      user.categories << Category.order("RANDOM()").first
      user.categories << Category.order("RANDOM()").first
      user.categories << Category.order("RANDOM()").first
      user.categories << Category.order("RANDOM()").first
    end

    CreateAdminService.new.call
    puts 'All done'
  end
end