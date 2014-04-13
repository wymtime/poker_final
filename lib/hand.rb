require_relative 'deck'

class Hand
  
  POKER_HANDS = {
    :straight_flush => 9,
    :four_of_a_kind => 8,
    :full_house => 7,
    :flush => 6,
    :straight => 5,
    :three_of_a_kind => 4,
    :two_pair => 3,
    :one_pair => 2,
    :highcard => 1 
  }

  def self.deal_from(deck)
    Hand.new(deck.take(5))
  end

  attr_accessor :cards

  def initialize(cards)
    @cards = cards
  end

  def beats?(hand)
    if POKER_HANDS[poker_hand] > POKER_HANDS[hand.poker_hand]
      true
    elsif POKER_HANDS[poker_hand] < POKER_HANDS[hand.poker_hand]
      false
    else #same poker hand types
      self_vals = @cards.map { |card| card = card.poker_value}.sort
      opps_vals = hand.cards.map { |card| card = card.poker_value}.sort
      5.times do |card_index|
        if self_vals[card_index] > opps_vals[card_index]
          return true
        end
      end
      return nil
    end
  end
  
  def return_cards(deck)
    deck.return(@cards)
    @cards = []
  end
  
  def poker_hand
    vals = @cards.map { |card| card = card.poker_value}.sort
    syms = @cards.map { |card| card = card.suit_to_s}
    if (vals.first - vals.last).abs == 4 and syms.count(syms.first) == 5
      return :straight_flush
    end
    if vals.count(vals.first) == 4 || vals.count(vals.last) == 4
      return :four_of_a_kind
    end
    if (vals.count(vals.first) == 3 and vals.count(vals.last) == 2) and 
       (vals.count(vals.first) == 2 and vals.count(vals.last) == 3)
         return :full_house
    end
    if syms.count(syms.first) == 5
      return :flush
    end
    if (vals.first - vals.last).abs == 4
      return :straight
    end
    if (vals.count(vals.first) == 3 || vals.count(vals.last) == 3)
      return :three_of_a_kind
    end
    if vals.uniq == 3
      return :two_pair
    end
    if (vals.first - vals.last).abs != 4
      return :highcard
    end
    return :one_pair
  end
end

# 
# #straigh flush
# 1, 1, 1, 1, 1
# 
# vals = Hand.cards.map { |card| card = card.poker_value}.sort
# syms = Hand.cards.map { |card| card = card.suit_to_s}
# if vals.first - vals.last == 4 and Hand.cards.count(syms.first) == 5
#   return :straight_flush
# end
# 
# # four of a kind
# 4, 1
# 
# if vals.count(vals.first) == 4 || vals.count(vals.last) == 4
#   return :four_of_a_kind
# end
# 
# # full house
# 3, 2
# 
# if (vals.count(vals.first) == 3 and vals.count(vals.last) == 2) and 
#    (vals.count(vals.first) == 2 and vals.count(vals.last) == 3)
#      return :full_house
# end
# 
# # flush
# 1, 1, 1, 1, 1
# 
# if Hand.cards.count(syms.first) == 5
#   return :flush
# end
# 
# # straight
# 1, 1, 1, 1, 1 --> highcard - lowcard == 4
# 
# if vals.first - vals.last == 4
#   return :straight
# end
# 
# # three of a kind
# 3, 1, 1 counts.count(1) == 2
# 
# if (vals.count(vals.first) == 3 || vals.count(vals.last) == 3)
#   return :three_of_a_kind
# end
# 
# # two pair
# 2, 2, 1 counts.count(2) == 2
# 
# if vals.uniq == 3
#   return :two_pair
# end
# 
# # one pair
# 2, 1, 1, 1
# 
# if vals.first - vals.last != 4
#   return :highcard
# end
# return :one_pair
# 
# # high card
# 1, 1, 1, 1, 1 --> highcard - lowcard != 4
