# -*- coding: utf-8 -*-

class Card
  SUIT_STRINGS = {
    :clubs    => "♣",
    :diamonds => "♦",
    :hearts   => "♥",
    :spades   => "♠"
  }

  VALUE_STRINGS = {
    :deuce => "2",
    :three => "3",
    :four  => "4",
    :five  => "5",
    :six   => "6",
    :seven => "7",
    :eight => "8",
    :nine  => "9",
    :ten   => "10",
    :jack  => "J",
    :queen => "Q",
    :king  => "K",
    :ace   => "A"
  }

  POKER_VALUE = {
    :deuce => 2,
    :three => 3,
    :four  => 4,
    :five  => 5,
    :six   => 6,
    :seven => 7,
    :eight => 8,
    :nine  => 9,
    :ten   => 10,
    :jack  => 11,
    :queen => 12,
    :king  => 13,
    :ace => 14
  }

  def self.suits
    SUIT_STRINGS.keys
  end #self.suits

  def self.values
    VALUE_STRINGS.keys
  end #self.values
  
  attr_reader :suit, :value

  def initialize(suit, value)
    unless Card.suits.include?(suit) and Card.values.include?(value)
      raise "illegal suit (#{suit}) or value (#{value})"
    end

    @suit, @value = suit, value
  end #init
  
  def poker_value
    POKER_VALUE[value]
  end
  
  def ==(other_card)
    return false if other_card.nil?

    [:suit, :value].all? do |attr|
      self.send(attr) == other_card.send(attr)
    end
  end

  def value_to_s
    VALUE_STRINGS[value]
  end

  def suit_to_s
    SUIT_STRINGS[suit]
  end

  def to_s
    value_to_s + suit_to_s
  end #to_s
end #Card