require 'deck'

class Hand

  def self.deal_from(deck)
    Hand.new(deck.take(5))
  end

  attr_accessor :cards

  def initialize(cards)
    @cards = cards
  end

  def beats?(hand)
  end
  
  def return_cards(deck)
    deck.return(@cards)
    @cards = []
  end

  def get_histogram(hand)
    #codex = {"♣" => 5}
    histogram_suit = {}
    histogram_vals = {}
    hand.cards.each do |card|
      if card.suits_to_s.count > 0
        histogram_suit[card.suits] = card.suits_to_s.count
      elsif card.values_to_s.count > 0
        histogram_vals[card.values] = card.values_to_s.count
      end
    end

    poker_hand(histogram_suit, histogram_vals)

    # Card.new.suits.each do |suit|
    #   if
    # end
    # Card.new.values.each do |value|
    #
  end #get_histogram

  def poker_hand(histogram_suit, histogram_vals)
    flush = false
    if histogram_suit.values.include?(5) #flush
      flush = true
    end #if

    # rubric for determining hand
    if histogram_vals.values.count(1) == 5 # high card or straight
      if cards.sort.last - cards.sort.first == 4
        # straight
      else
        #high cards
    elsif histogram_vals.values.count(1) == 2 # four of a kind or full house
      if card.count(card[0]) == 2 || card.count(card[0]) == 3
        # full house
      else
        # four of a kind
    elsif histogram_vals.values.count(1) == 3 # two pair of three of kind
    else # one pair
    end #if

    if histogram_vals.values.include?(3)


  end #poker_hand
end #Hand
#straigh flush
1, 1, 1, 1, 1
# four of a kind
4, 1
# full house
3, 2
# flush
1, 1, 1, 1, 1
# straight
1, 1, 1, 1, 1 --> highcard - lowcard == 4
# three of a kind
3, 1, 1 counts.count(1) == 2
# two pair
2, 2, 1 counts.count(2) == 2
# one pair
2, 1, 1, 1
# high card
1, 1, 1, 1, 1 --> highcard - lowcard != 4
