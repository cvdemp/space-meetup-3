class User < ActiveRecord::Base
  has_many :meetups, through: :attendees

  validates :provider, presence: true, on: :create
  validates :uid, presence: true, on: :create
  validates :username, presence: true, on: :create
  validates :email, presence: true, on: :create
  validates :avatar_url, presence: true, on: :create
  
  def self.find_or_create_from_omniauth(auth)
    provider = auth.provider
    uid = auth.uid

    find_by(provider: provider, uid: uid) || create_from_omniauth(auth)
  end

  def self.create_from_omniauth(auth)
    create(
      provider: auth.provider,
      uid: auth.uid,
      email: auth.info.email,
      username: auth.info.nickname,
      avatar_url: auth.info.image
    )
  end
end
