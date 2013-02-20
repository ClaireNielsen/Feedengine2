class Feed < ActiveRecord::Base
  attr_accessible :body, :private, :title, :user_id

  belongs_to :user
  has_many :permissions
end
