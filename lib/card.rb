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

  attr_reader :suit

  def suits
    SUIT_STRINGS.keys
  end #self.suits

  def values
    VALUE_STRINGS.keys
  end #self.values

  def initialize(suit=:clubs, value=:deuce)
    @suit, @value = suit, value
  end #init

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