namespace :dev do

  task :fake => :environment do
    users = []
    10.times do
      users << User.create!( :email => Faker::Internet.email, :password => "123123")
    end

    50.times do
      post = Post.create!( :content => Faker::Lorem.paragraph,
                          :user_id => users.sample.id)
    end
  end
end
