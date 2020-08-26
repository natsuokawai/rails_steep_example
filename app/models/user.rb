class User < ApplicationRecord
  has_many :books

  scope :admin, -> { where(admin: true) }
end
