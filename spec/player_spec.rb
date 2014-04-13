require 'player'
require 'rspec'

describe Player do
  subject(:player) { Player.new }

  describe "#discard" do
    it "should throw exception if array passed is greater than 3" do
      expect {
        player.discard([1, 2, 2, 5])
      }.to raise_exception
    end

    it "should be passed an array of size 3 or less" do
      expect {
        player.discard([1, 3, 2])
      }.to_not raise_exception
    end

    it "should return array of kept cards" do
      player.discard([0, 1]).cards.count.should == 3
    end

    it "should accept valid inputs and indices" do
      expect {
        player.discard([1, 'f', 2])
      }.to raise_exception
    end
  end #discard

  #describe ""

end #Player