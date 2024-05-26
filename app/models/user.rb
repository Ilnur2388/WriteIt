class User < ApplicationRecord
  enum role: { basic: 0, admin: 2 }
  has_secure_password

  has_many :posts, dependent: :destroy

  validates :name, presence: true
  validates :city, presence: true, unless: -> { role == 'admin' }

  def author?(obj)
    obj.user == self
  end
end
