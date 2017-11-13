FactoryBot.define do
  factory :issue do
    association :requester, factory: :user

    summary { Faker::Lorem.sentence }
    description { Faker::Lorem.paragraph }
  end
end
