require 'hand'
require 'rspec'

describe Hand do
  subject(:hand) { Hand.new }

  describe "#discard" do
    it "should remove the number of cards from hand" do
      hand.discard(2)
      hand.cards.count.should == 5
    end #it

    it

  end #discard
end #Card