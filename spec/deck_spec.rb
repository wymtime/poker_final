require 'deck'
require 'rspec'

describe Deck do
  subject(:deck) { Deck.new }

  describe "#build_deck" do
    it "should return a deck" do
      expect(deck.cards.count).to eq(52)
    end

    it "should contain all unique cards" do
      expect(deck.cards.uniq).to eq(deck.cards)
    end
  end #build_deck

  describe "#deal" do
    # it "should receive take method" do
    #   expect(deck.deal).to receive(:take).with(2)
    #   deck.deal(2)
    # end

    it "should return an array of cards" do
      expect(deck.deal(2)).to be_a(Array)
    end

    it "returns returns the same number of cards" do
      expect(deck.deal(2).count).to eq(2)
    end

    it "should reduce deck count by number" do
      deck.deal(6)
       expect(deck.cards.count).to eq(46)
    end
  end

  describe "#take" do
    it "returns an array of items minus the " do
      expect(deck.take(2).count).to eq(2)
    end
  end #take

  describe "#shuffle" do
    it "returns a shuffled array" do
      expect(deck).to_not eq(deck.shuffle)
    end
  end

end #Deck