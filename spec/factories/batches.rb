FactoryBot.define do
  factory :batch do
    name { "Batch A" }
    association :course
  end
end
