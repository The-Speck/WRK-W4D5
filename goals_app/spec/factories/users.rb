FactoryBot.define do
  factory :user do
    username { Faker::DragonBall.character }
    password { Faker::Internet.password }
  end
end
