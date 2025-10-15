class PostsProducer
  def self.call(post)
    payload = {
      post_id: post.id,
      title: post.title,
      created_at: post.created_at.iso8601
    }

    Karafka.producer.produce_async(
      topic: "posts",
      payload: payload.to_json
    )

    Rails.logger.info "Published post #{post.id} to Kafka topic 'posts'"
  end
end
