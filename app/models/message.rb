class Message < ApplicationRecord
  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?

  belongs_to :user

  validates :hint, presence: true
  validates :address, presence: true

end
