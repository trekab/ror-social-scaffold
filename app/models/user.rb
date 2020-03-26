class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true, length: { maximum: 20 }

  has_many :posts
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :friends
  has_many :inverse_friends, class_name: 'Friend', foreign_key: 'pal_id'

  def pals
    friends.map { |friend| friend.pal if friend.accepted? }.compact
  end

  def pending_friends
    friends.map { |friend| friend.pal if friend.pending? }.compact
  end

  def friend_requests
    inverse_friends.map { |friend| friend.user unless friend.accepted? }.compact
  end

  def confirm_friend(user)
    pal = inverse_friends.find { |friend| friend.user == user }
    pal.accepted!
  end

  def friend?(user)
    pals.include?(user)
  end
end
