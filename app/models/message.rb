class Message < ApplicationRecord
  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?

  belongs_to :user
  has_many :message_users
  has_many :recipients, through: :message_users, source: :user
  validates :hint, presence: true
  validates :address, presence: true
  has_rich_text :content
  has_one_attached :photo
end
