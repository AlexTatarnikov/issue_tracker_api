FactoryBot.define do
  factory :issue do
    summary { Faker::Lorem.sentence }
    description summary { Faker::Lorem.paragraph }
  end
end
