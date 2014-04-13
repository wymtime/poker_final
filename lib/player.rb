require 'hand'
require 'deck'

class Player
  
  attr_reader :name, :bankroll, :check
  attr_accessor :hand #, :pot

  def initialize(name, bankroll)
    @name = name
    @bankroll = bankroll
    @check = false
  end

  def fold(deck)
    return_cards(deck)
  end

  def raise_bet(raise_amt, game)
    raise "player can't cover raise" if raise_amt > @bankroll
    game.take_amt(self, raise_amt)
    @bankroll -= raise_amt
  end

  def call(call_amt, game)
    raise "player can't cover call" if call_amt > @bankroll
    game.take_amt(self, call_amt)
    @bankroll -= call_amt
  end
  
  def check?
    @check
  end
  
  def pay_out(pot)
    @bankroll += pot
  end
  
  def discard(card_indices, deck)
    if card_indices.count > 3
      raise "cannot trade that many cards"
    end
    if !card_indices.all? { |index| index.is_a?(Fixnum) && index < 5 }
      raise "please provide proper indices"
    end
    discarded = @hand.cards.values_at(*card_indices)
    deck.return(discarded)
    #select only the cards that are not in card_indices
    @hand.cards.select! { |card| !card_indices.include?(@hand.cards.index(card)) }
    #replace however many cards have been discarded
    @hand.cards += deck.take(discarded.count)
  end
  
  def return_cards(deck)
    @hand.return_cards(deck)
    @hand = nil
  end
  
  def display_hand
    @hand.cards.map { |card| card.to_s}.join(' ')
  end
end