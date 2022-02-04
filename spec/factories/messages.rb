FactoryBot.define do
  factory :message do
    author { FactoryBot.create :user }
    sequence(:body) { |n| "Message number #{n}" }
  end
end
