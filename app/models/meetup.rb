class Meetup < ActiveRecord::Base
  has_many :attendees, through: :users
  validates :title, presence: true
  validates :title, length: {maximum: 100}
  validates :description, presence: true
  validates :description, length: {maximum: 200}
  validates :location, presence: true
end
