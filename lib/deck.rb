require 'card'

class Deck

  def self.all_cards
    new_cards = []
    Card.suits.each do |suit|
      Card.values.each do |value|
        new_cards << Card.new(suit, value)
      end
    end
    new_cards
  end

  def initialize(cards = Deck.all_cards)
    @cards = cards
    shuffle
  end #end
  
  def count
    @cards.count
  end

  def take(n) # Taking cards out of the deck
    taken = []
    n.times do
      taken << cards.shift
    end
    taken
  end #take

  def shuffle
    cards.shuffle
  end #shuffle
  
  def return(cards)
    @cards += cards
  end
end