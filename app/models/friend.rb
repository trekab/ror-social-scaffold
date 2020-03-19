class Friend < ApplicationRecord
  enum friendship_status: { pending: 0, accepted: 1, denied: 2}
  belongs_to :user
  belongs_to :pal, class_name: 'User'
end
