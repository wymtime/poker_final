require_relative 'player'

class Game
  attr_accessor :pot, :deck, :players, :bets
  
  def initialize(*players, deck)
    @pot = 0
    @bets = {}
    @deck = deck
    @deck.shuffle
    @players = players
    @players.each { |player| player.hand = Hand.deal_from(@deck) }
    @players.each { |player| @bets[player] = 0 }
  end

  def start
    until @players.select {|player| player.bankroll > 0}.count == 1
      new_round
      2.times do |r|
        begin
          reset_checks
          round
          if r == 0
            begin
              do_discards
            rescue RuntimeError => e
              puts ""
              puts "#{e.message}"
              puts ""
              retry
            end
          end
        rescue RuntimeError => e
          puts ""
          puts "#{e.message}"
          puts ""
          retry
        end
      end
      pay_bets
      reset_bets
    end
    winner = @players.select { |player| player.bankroll > 0 }.first
    puts "#{winner.name} you have won the game! You now have $#{winner.bankroll}"
  end
  
  def new_round
    @players.each { |player| player.return_cards(@deck) }
    @deck.shuffle
    @players.each { |player| player.hand = Hand.deal_from(@deck) }
  end
  
  def all_players_checked?
    @players.all? {|player| player.check?}
  end
  
  def last_player_in_play?
    @players.select { |player| !player.folded? }.count == 1
  end

  def round
    #NEED TO ADD SET CHECK METHOD TO Player Class
    until all_players_checked? || last_player_in_play?
      @players.each do |player|
        #if player is max bet, they can either check, raise or fold
        #else they must call, raise or fold
        puts "#{player.name}, you have $#{player.bankroll} on your bankroll."
        puts "The pot is: $#{@pot}"
        #puts "The current bet is: $#{max_bet}"
        puts "Your bet is: $#{@bets[player]}"
        puts "#{player.name} your cards are #{player.display_hand}"
        
        #if the player is max better either check, raise or fold
        if @bets[player] == max_bet
          puts "You may check, raise or fold."
          response = gets.chomp.downcase
          
          if !["check", "raise", "fold", "call"].include?(response)
            raise "incorrect input please try again"
          end
          
          if response == "call"
            raise "You cannot call, you have the highest bet amount."
          end
        else
          puts "Would you like to raise, call, check or fold?"
          response = gets.chomp.downcase
          
          if !["check", "raise", "fold", "call"].include?(response)
            raise "incorrect input please try again"
          end
        end
        
        
        #puts "Do you raise, call, check or fold?"
        if response == "raise"
          puts "How much would you like to raise your bet?"
          amt = gets.chomp.to_i
          if @bets[player] + amt < max_bet
            raise "You must raise your bet by at least $#{max_bet - @bets[player]}"
          end
          player.raise_bet(amt, self)
        elsif response == "call"
          player.call_bet(max_bet - @bets[player], self)
        elsif response == "fold"
          player.fold(@deck)
        else
          player.set_check
        end
        puts ""
      end
    end
    puts ""
  end #player_turn
  
  def do_discards
    @players.each do |player|
      puts "#{player.name} your cards are #{player.display_hand}"
      if !player.folded?
        puts "Select indices of any cards you would like to discard (0-4)."
        indices = gets.chomp.split(' ').map! { |index| index.to_i}
        if !indices.empty?  
          player.discard(indices, @deck)
        end
      end
      puts ""
    end
  end
  
  def max_bet
    @bets.values.max
  end
  
  def reset_checks
    @players.each { |player| player.uncheck }
  end
  
  def reset_bets
    @players.each { |player| @bets[player] = 0 }
  end
  
  def take_amt(player, amt)
    #if @bets.keys.include?(player)
      @bets[player] += amt
      #else
      #@bets[player] = amt
      #end
    @pot += amt
  end
  
  def pay_bets
    winner = nil
    ties = []
    0.upto(@bets.keys.count - 2) do |p1|
      (p1+1).upto(@bets.keys.count - 1) do |p2|
        if @players[p1].hand.beats?(@players[p2].hand)
          winner = @players[p1]
        elsif @players[p1].hand.beats?(@players[p2].hand).nil?
          ties << @players[p1]
          ties << @players[p2]
        end
      end
    end
    if ties.empty?
      winner.pay_out(@pot)
      puts "#{winner.name} wins the round!"
    else
      ties.each do |player|
        player.pay_out(@pot / ties.count)
        puts "#{player.name} had tied, your payout is $#{@pot / ties.count}"
      end
    end
    @pot = 0
  end
end

deck = Deck.new

g = Game.new(Player.new("Joe", 25000), Player.new("Mike", 25000), deck)
g.start