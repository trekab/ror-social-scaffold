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
  has_many :inverse_friends, :class_name => "Friend", :foreign_key => "pal_id"

  def friends
    pals_array = friends.map{|friend| friend.pal if friend.friendship_status}
    pals_array + inverse_friends.map{|friend| friend.user if friend.friendship_status}
    pals_array.compact
  end

  def pending_friends
    friends.map{|friend| friend.pal if !friend.friendship_status}.compact
  end

  def friend_requests
    inverse_friends.map{|friend| friend.user if !friend.friendship_status}.compact
  end

  def confirm_friend(user)
    friend = inverse_friends.find{|friend| friend.user == user}
    friend.friendship_status = true
    friend.save
  end

  def friend?(user)
    friends.include?(user)
  end
end
