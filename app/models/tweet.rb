class Tweet
  def initialize user_id, tweet_amount
    @user_id = user_id
    @tweet_amount = tweet_amount
  end

  def get_tweet
    tweets = Twitter.user_timeline(@user_id, {:amount=>@tweet_amount, :page=>1})
    tweets.map {|t| [t.created_at.strftime("%Y/%m/%d %H:%M"), t.text]}
  end
end
