namespace :analyze_tweet do
  desc "tweet取得"

  task :get_tweet, [:user_id, :tweet_amount] => :environment do |task, args|
    USER_ID = args[:user_id] # ツイートを取得したいユーザの ID
    TWEET_AMOUNT = args[:tweet_amount]    # 一度に取得するツイート数. 最大値は 200.

    tweets = Twitter.user_timeline(USER_ID, {:amount=>TWEET_AMOUNT, :page=>1})
    tweets.each do |t|
      puts "#{t.created_at.strftime("%Y/%m/%d %H:%M")} #{t.text}"
    end
  end
end
