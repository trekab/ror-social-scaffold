class Friend < ApplicationRecord
  belongs_to :user
  belongs_to :pal, class_name: 'User'
end
