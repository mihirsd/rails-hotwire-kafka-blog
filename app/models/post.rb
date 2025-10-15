class Post < ApplicationRecord
  has_many :comments, dependent: :destroy
  validates :title, :body, presence: true

  broadcasts_to ->(post) { "posts" }, inserts_by: :prepend
  after_create_commit :publish_to_kafka

  private

  def publish_to_kafka
    PostsProducer.call(self)
  end
end
