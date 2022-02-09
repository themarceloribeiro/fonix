class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable

  has_many :messages, foreign_key: :author_id
  has_many :group_users
  has_many :groups, through: :group_users
end
