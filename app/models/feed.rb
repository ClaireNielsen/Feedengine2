class Feed < ActiveRecord::Base
  attr_accessible :body, :private, :title, :user_id

  belongs_to :user
  has_many :permissions
  has_many :users, :through => :permissions

end
