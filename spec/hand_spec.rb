require 'hand'
require 'rspec'

describe Hand do
  subject(:hand) { Hand.new }

  # describe "#discard" do
  #   it "should remove the number of cards from hand" do
  #     hand.discard(2)
  #     hand.cards.count.should == 5
  #   end #it
  # 
  # end #discard
  
  describe "#poker_hand" do
    it "should return :straight_flush" do
      hand1 = Hand.new([
        Card.new(:clubs, :eight),
        Card.new(:clubs, :seven),
        Card.new(:clubs, :six),
        Card.new(:clubs, :five),
        Card.new(:clubs, :four)
        ])
        expect(hand1.poker_hand.to_s).to eq("straight_flush")
    end
    
    it "should return :four_of_a_kind" do
      hand2 = Hand.new([
        Card.new(:clubs, :six),
        Card.new(:diamonds, :six),
        Card.new(:hearts, :six),
        Card.new(:spades, :six),
        Card.new(:clubs, :ace)
        ])
        expect(hand2.poker_hand.to_s).to eq("four_of_a_kind")
    end
  end
  
  describe "#beats" do
    it "a straight flush beats four of a kind" do
      hand1 = Hand.new([
        Card.new(:clubs, :eight),
        Card.new(:clubs, :seven),
        Card.new(:clubs, :six),
        Card.new(:clubs, :five),
        Card.new(:clubs, :four)
        ])
      hand2 = Hand.new([
        Card.new(:clubs, :six),
        Card.new(:diamonds, :six),
        Card.new(:hearts, :six),
        Card.new(:spades, :six),
        Card.new(:clubs, :ace)
        ])

      expect(hand1.beats?(hand2)).to be(true)
      expect(hand2.beats?(hand1)).to be(false)
    end
    
    it "a straight flush beats a lesser straight flush" do
      hand1 = Hand.new([
        Card.new(:hearts, :eight),
        Card.new(:hearts, :seven),
        Card.new(:hearts, :six),
        Card.new(:hearts, :five),
        Card.new(:hearts, :four)
        ])
      hand2 = Hand.new([
        Card.new(:spades, :six),
        Card.new(:spades, :five),
        Card.new(:spades, :four),
        Card.new(:spades, :three),
        Card.new(:spades, :deuce)
        ])

      expect(hand1.beats?(hand2)).to be(true)
      expect(hand2.beats?(hand1)).to be(false)
    end
  end
end #Card