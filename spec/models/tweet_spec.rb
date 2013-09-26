require 'spec_helper'

describe Tweet do
  describe 'analyze' do
    before do
      @tweet_manager = Tweet.new('46goma_cytus', 20)
    end
    describe 'cytusテンプレの前後になんか入ってても問題ないか' do
      context '前になんか入ってる時' do
        it '解析されて正しく各キーに値が入ること' do
          tweets = [
            ["2013-09-21 18:32:00",
             "クリアできたよかった！！Cytusで遊んでいます。そして、先《Majestic Phoenix/Hard》で799,891点を取った、ランクCだよ。早く参加して、一緒に遊ぼう！ http://t.co/e7ddwMp5vv"]]
          results = []
          result = {}
          result[:datetime] = '2013-09-21 18:32:00'
          result[:title] = 'Majestic Phoenix'
          result[:difficulty] = 'Hard'
          result[:score] = 799891
          result[:rank] = 'C'
          results << result

          @tweet_manager.analyze(tweets).should eq results
        end
      end
      context '後ろになんか入ってる時' do
        it '解析されて正しく各キーに値が入ること' do
          tweets = [
            ["2013-09-21 18:32:00",
             "Cytusで遊んでいます。そして、先《Majestic Phoenix/Hard》で799,891点を取った、ランクCだよ。早く参加して、一緒に遊ぼう！ http://t.co/e7ddwMp5vv クリアできたよかった！！"]]
          results = []
          result = {}
          result[:datetime] = '2013-09-21 18:32:00'
          result[:title] = 'Majestic Phoenix'
          result[:difficulty] = 'Hard'
          result[:score] = 799891
          result[:rank] = 'C'
          results << result

          @tweet_manager.analyze(tweets).should eq results
        end
      end
    end
    describe 'tweet件数を変えても問題がないかどうか' do
      context 'tweetが0件の時' do
        it '空の配列が帰ること' do
          tweets = []
          results = []
          @tweet_manager.analyze(tweets).should eq results
        end
      end
      context 'tweetが1件の時' do
        it '解析されて正しく各キーに値が入ること' do
          tweets = [
            ["2013-09-21 18:32:00",
             "Cytusで遊んでいます。そして、先《Majestic Phoenix/Hard》で799,891点を取った、ランクCだよ。早く参加して、一緒に遊ぼう！ http://t.co/e7ddwMp5vv"]
          ]
          results = []
          result = {}
          result[:datetime] = '2013-09-21 18:32:00'
          result[:title] = 'Majestic Phoenix'
          result[:difficulty] = 'Hard'
          result[:score] = 799891
          result[:rank] = 'C'
          results << result

          @tweet_manager.analyze(tweets).should eq results
        end
      end
      context 'tweetが複数件の時' do
        it '解析されて正しく各キーに値が入ること' do
          tweets = [
            ["2013-09-21 18:32:00",
             "Cytusで遊んでいます。そして、先《Majestic Phoenix/Hard》で799,891点を取った、ランクCだよ。早く参加して、一緒に遊ぼう！ http://t.co/e7ddwMp5vv"],
            ["2013-09-21 18:33:00",
             "Cytusで遊んでいます。そして、先《Majestic Phoenix/Hard》で899,891点を取った、ランクBだよ。早く参加して、一緒に遊ぼう！ http://t.co/e7ddwMp5vv"]
          ]
          results = []
          result = {}
          result[:datetime] = '2013-09-21 18:32:00'
          result[:title] = 'Majestic Phoenix'
          result[:difficulty] = 'Hard'
          result[:score] = 799891
          result[:rank] = 'C'
          results << result
          result = {}
          result[:datetime] = '2013-09-21 18:33:00'
          result[:title] = 'Majestic Phoenix'
          result[:difficulty] = 'Hard'
          result[:score] = 899891
          result[:rank] = 'B'
          results << result

          @tweet_manager.analyze(tweets).should eq results
        end
      end
    end

    describe '特定条件を満たすtweetでもただしく動くかどうかのテスト' do
      context 'titleに《が入っている時' do
        it '解析されて正しく各キーに値が入ること' do
          tweets = [
            ["2013-09-21 18:32:00",
             "Cytusで遊んでいます。そして、先《test《test/Hard》で799,891点を取った、ランクCだよ。早く参加して、一緒に遊ぼう！ http://t.co/e7ddwMp5vv"]
          ]
          results = []
          result = {}
          result[:datetime] = '2013-09-21 18:32:00'
          result[:title] = 'test《test'
          result[:difficulty] = 'Hard'
          result[:score] = 799891
          result[:rank] = 'C'
          results << result

          @tweet_manager.analyze(tweets).should eq results
        end
      end
      context 'titleに/が入っている時' do
        it '解析されて正しく各キーに値が入ること' do
          tweets = [
            ["2013-09-21 18:32:00",
             "Cytusで遊んでいます。そして、先《test/test/Hard》で799,891点を取った、ランクCだよ。早く参加して、一緒に遊ぼう！ http://t.co/e7ddwMp5vv"]
          ]
          results = []
          result = {}
          result[:datetime] = '2013-09-21 18:32:00'
          result[:title] = 'test/test'
          result[:difficulty] = 'Hard'
          result[:score] = 799891
          result[:rank] = 'C'
          results << result

          @tweet_manager.analyze(tweets).should eq results
        end
      end
      context 'scoreに,が複数入っている時' do
        it '解析されて正しく各キーに値が入ること' do
          tweets = [
            ["2013-09-21 18:32:00",
             "Cytusで遊んでいます。そして、先《Majestic Phoenix/Hard》で1,000,000点を取った、ランクCだよ。早く参加して、一緒に遊ぼう！ http://t.co/e7ddwMp5vv"]
          ]
          results = []
          result = {}
          result[:datetime] = '2013-09-21 18:32:00'
          result[:title] = 'Majestic Phoenix'
          result[:difficulty] = 'Hard'
          result[:score] = 1000000
          result[:rank] = 'C'
          results << result

          @tweet_manager.analyze(tweets).should eq results
        end
      end
      context 'scoreに,が入っていない時' do
        it '解析されて正しく各キーに値が入ること' do
          tweets = [
            ["2013-09-21 18:32:00",
             "Cytusで遊んでいます。そして、先《Majestic Phoenix/Hard》で123点を取った、ランクCだよ。早く参加して、一緒に遊ぼう！ http://t.co/e7ddwMp5vv"]
          ]
          results = []
          result = {}
          result[:datetime] = '2013-09-21 18:32:00'
          result[:title] = 'Majestic Phoenix'
          result[:difficulty] = 'Hard'
          result[:score] = 123
          result[:rank] = 'C'
          results << result

          @tweet_manager.analyze(tweets).should eq results
        end
      end
    end
  end
end
