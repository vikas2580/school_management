FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "user#{n}@example.com" }
    password { "password123" }
    role { :student }

    factory :admin_user do
      role { :admin }
    end

    factory :school_admin_user do
      role { :school_admin }
      association :school
    end
  end
end
