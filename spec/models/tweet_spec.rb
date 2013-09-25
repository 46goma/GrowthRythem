require 'spec_helper'

describe Tweet do
  describe "analyze" do
    before do
      @tweet_manager = Tweet.new('46goma_cytus', 20)
    end
    it "解析されて正しく各キーに値が入ること" do
      tweets = [
        ["2013/09/21 18:32:00",
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
end
