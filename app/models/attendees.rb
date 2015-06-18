class Attendee < ActiveRecord::Base
  belongs_to :user
  validates :user, presence: true, on: :create

  belongs_to :meetup
  validates :meetup, presence: true, on: :create

  validates :owner, :inclusion => { :in => [true, false] }

end
