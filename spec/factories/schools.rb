FactoryBot.define do
  factory :school do
    name { "Test School" }
    association :created_by, factory: :admin_user
  end
end
