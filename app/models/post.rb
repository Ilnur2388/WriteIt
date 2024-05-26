class Post < ApplicationRecord
  enum state: { draft: 0, review: 2, approved: 3, rejected: 4 }
  belongs_to :user
  has_many_attached :images do |attachable|
    attachable.variant :thumb, resize_to_limit: [100, 100]
  end
  validates :title, presence: true
  validates :body, presence: true
end
