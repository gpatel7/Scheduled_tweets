class TweetJob < ApplicationJob
  queue_as :default

  # do not cancel job. Instead allow adding new one and allow old job to do nothing
  def perform(tweet)
    binding.irb
    return if tweet.published?
    #rescheduled a tweet to future
    return if tweet.publish_at > Time.current
    tweet.publish_to_twitter!
  end
end
