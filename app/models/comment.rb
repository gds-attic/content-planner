class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :commentable, polymorphic: true

  validates :commentable_id, presence: true
  validates :commentable_type, presence: true
end
