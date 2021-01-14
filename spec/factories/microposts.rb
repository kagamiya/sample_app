FactoryBot.define do
  factory :micropost do
    sequence(:content) { |n| "TEST_CONTENT#{n}" }
    sequence(:user_id) { |n| n }
    picture { "" }
  end
end
