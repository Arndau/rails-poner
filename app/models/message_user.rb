class MessageUser < ApplicationRecord
  belongs_to :message
  belongs_to :user

  validates :unlocked, presence: true
  validates :read, presence: true
end
