class Comment < ApplicationRecord
  belongs_to :post
  validates :body, presence: true

  broadcasts_to :post
end
