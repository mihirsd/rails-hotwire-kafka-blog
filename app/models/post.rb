class Post < ApplicationRecord
  has_many :comments, dependent: :destroy
  validates :title, :body, presence: true

  broadcasts_to ->(post) { "posts" }, inserts_by: :prepend
end
