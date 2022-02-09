class Message < ApplicationRecord
  belongs_to :author, class_name: 'User'
  belongs_to :group, required: false

  validate :user_has_rights

  def user_has_rights
    errors.add(:base, 'Not allowed') unless author.groups.include?(group)
  end
end
