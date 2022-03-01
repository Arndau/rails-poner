class Message < ApplicationRecord
  belongs_to :user

  validates :hint, presence: true
  validates :address, presence: true
  validates :longitude, presence: true
  validates :latitude, presence: true

end
