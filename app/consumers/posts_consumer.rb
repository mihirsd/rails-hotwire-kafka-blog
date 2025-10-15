# frozen_string_literal: true

# Example consumer that prints messages payloads
class PostsConsumer < ApplicationConsumer
  def consume
    messages.each do |message|
      Rails.logger.info "======================================="
      Rails.logger.info "Kafka Message Received on 'posts' topic"
      Rails.logger.info "Post ID: #{message.payload['post_id']}"
      Rails.logger.info "Title: #{message.payload['title']}"
      Rails.logger.info "Created At: #{message.payload['created_at']}"
      Rails.logger.info "======================================="
    end
  end
end
