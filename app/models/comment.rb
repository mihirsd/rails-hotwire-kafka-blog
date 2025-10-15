class Comment < ApplicationRecord
  belongs_to :post
  validates :body, :name, presence: true

  broadcasts_to :post
end
