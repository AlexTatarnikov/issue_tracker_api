FactoryBot.define do
  factory :issue do
    association :requester, factory: :user
    association :manager, factory: :manager

    summary { Faker::Lorem.sentence }
    description { Faker::Lorem.paragraph }

    state { 'pending' }
  end
end
