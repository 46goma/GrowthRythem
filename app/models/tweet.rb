class Tweet
  def self.get_tweet(user_id, tweet_amount)
    tweets = Twitter.user_timeline(user_id, {:amount=>tweet_amount, :page=>1})
    tweets.map {|t| [t.created_at.strftime("%Y/%m/%d %H:%M"), t.text]}
  end
end
