FactoryBot.define do
  factory :course do
    name { "Ruby Course" }
    association :school
  end
end
