namespace :analyze_tweet do
  desc "tweet取得"

  task :get_tweet, [:user_id, :tweet_amount] => :environment do |task, args|
    tweets = Tweet.get_tweet(args[:user_id], args[:tweet_amount])
  end
end
