require 'hand'
require 'deck'

class Player

  POKER_HANDS {
    one_pair => 1

  }

  attr_accessor :hand

  def initialize(hand = [])
    @hand = Hand.new(Deck.new)
    #@money
  end

  def discard(indices)
    if indices.count > 3
      raise "cannot trade that many cards"
    end
    if !indices.all? { |index| index.is_a?(Fixnum) && index < 5 }
      raise "please provide proper indices"
    end
    indices.each do |card_index|
      hand.cards.delete_at(card_index)
    end
    hand
  end

  def fold
  end

  def raise_bet
  end

  def call
  end

  def check
  end

end