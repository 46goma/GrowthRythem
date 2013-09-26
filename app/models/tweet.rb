class Tweet
  def initialize user_id, tweet_amount
    @user_id = user_id
    @tweet_amount = tweet_amount
  end

  def get_tweets
    tweets = Twitter.user_timeline(@user_id, {:amount=>@tweet_amount, :page=>1})
    tweets.map {|t| [t.created_at.strftime("%Y-%m-%d %H:%M:%S"), t.text]}
  end
  def analyze tweets
    results = tweets.map do |tweet|
      result = {}
      parsed_tweet = tweet.last.match(%r{《(.*)/(.*)》で(.*)点を取った、ランク(.*)だ})
      result[:datetime] = tweet.first
      result[:title] = parsed_tweet[1]
      result[:difficulty] = parsed_tweet[2]
      result[:score] = parsed_tweet[3].gsub(',','').to_i
      result[:rank] = parsed_tweet[4]
      result
    end
    results
  end
end
