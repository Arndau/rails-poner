class MessageUser < ApplicationRecord
  belongs_to :message
  belongs_to :user

  validates :unlocked, presence: true, default: false
  validates :read, presence: true, default: false

end
