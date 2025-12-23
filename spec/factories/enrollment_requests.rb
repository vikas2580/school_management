FactoryBot.define do
  factory :enrollment_request do
    status { "pending" }

    association :student, factory: :user
    association :batch
  end
end
