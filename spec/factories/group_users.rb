FactoryBot.define do
  factory :group_user do
    user { FactoryBot.create :user }
    group { FactoryBot.create :group }
  end
end
