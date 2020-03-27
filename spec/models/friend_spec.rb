require 'rails_helper'

RSpec.describe Friend, type: :model do
  context 'Creating friendships' do
    user1 = User.new(name: 'Arya', email: 'arya@ymail.com', password: 'password')
    if user1.valid?
      user1.save
      user2 = User.new(name: 'Sansa', email: 'sansa@ymail.com', password: 'password')
      user2.save
    else
      user1 = User.first
      user2 = User.second
    end

    it 'must create a friendship between two users' do
      friendship = Friend.new(user_id: user1.id, pal_id: user2.id, friendship_status: 1)
      friendship.save
      expect(friendship.valid?).to be true
    end
  end
end
