class Feature < ApplicationRecord
  has_many :comments

  validates :title, :url, :place, :mag_type, presence: true
  validates :mag, numericality: { in: -1.0..10.0 }
  validates :latitude, numericality: { in: -90.0..90.0 }
  validates :longitude, numericality: { in: -180.0..180.0 }
  validates :record_id, uniqueness: true

  scope :by_mag_type, ->(mag_type) { where(mag_type:) }
end
