namespace :analyze_tweet do
  desc "tweet取得"

  task :get_tweets, [:user_id, :tweet_amount] => :environment do |task, args|
    tweet_manager = Tweet.new(args[:user_id], args[:tweet_amount])
    tweet_manager.get_tweets
  end
end
