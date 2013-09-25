class Tweet
  def initialize user_id, tweet_amount
    @user_id = user_id
    @tweet_amount = tweet_amount
  end

  def get_tweets
    tweets = Twitter.user_timeline(@user_id, {:amount=>@tweet_amount, :page=>1})
    hoge = tweets.map {|t| [t.created_at.strftime("%Y-%m-%d %H:%M:%S"), t.text]}
    binding.pry
  end
  def analyze tweets
      results = []
      result = {}
      result[:datetime] = '2013-09-21 18:32:00'
      result[:title] = 'Majestic Phoenix'
      result[:difficulty] = 'Hard'
      result[:score] = 799891
      result[:rank] = 'C'
      results << result
      results
  end
end
