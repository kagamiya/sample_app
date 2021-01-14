FactoryBot.define do
  factory :user do
    sequence(:name) { |n| "TEST_NAME#{n}" }
    sequence(:email) { |n| "TEST#{n}@example.com" }
    password { "foobar" }
    password_confirmation { "foobar" }
    admin { false }
  end
end
