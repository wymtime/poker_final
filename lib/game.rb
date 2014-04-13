class Game
  attr_accessor :pot, :deck, :players, :bets
  
  def initialize(*players)
    @pot = 0
    @bets = {}
    @deck = Deck.new
    @players = players
  end

  def start
    until @players.select {|player| player.bankroll > 0}.count == 1
      
    end
  end

  def round
    #NEED TO ADD SET CHECK METHOD TO Player Class
    reset_checks
    until @players.all? {|player| player.check?}
      @player.each do |player|
        #if player is max bet, they can either check, raise or fold
        #else they must call, raise or fold
        puts "#{player.name}, you have $#{player.bankroll} on your bankroll."
        puts "The pot is: $#{@pot}"
        puts "The current bet is: $#{max_bet}"
        puts "Your bet is: #{@bets[player]}"
        
        #if the player is max better either check, raise or fold
        if @bets[player] == @bets.values.max
          puts "You are the max better, you may check, raise or fold."
          response = gets.chomp.downcase
          if response == "call"
            raise "You cannot call, you have the highest bet amount."
        else
          puts "Would you like to raise, call check or fold?"
          response = gets.chomp.downcase
        end
        
        
        #puts "Do you raise, call, check or fold?"
        if response == "raise"
          puts "How much would you like to raise your bet?"
          amt = gets.chomp.to_i
          if @bets[player] + amt < max_bet
            raise "You must raise your bet by at least $#{max_bet - @bets[player]}"
          player.raise_bet(amt, self)
        elsif response == "call"
          player.call_bet(max_bet - @bets[player], self)
        elsif response == "fold"
          player.fold
        else
          player.set_check
        end
      end
    end
    @players.each do |player|
      puts "#{player.name} your cards are #{player.cards.map { |card| card.to_s }.join(' ')}"
      puts "Select indices of any cards you would like to discard (0-4)."
      indices = gets.chomp.split(' ').map { |index| index.to_i}
      if !indices.empty?  
        player.discard(indices)
      end
    end
  end #player_turn
  
  def max_bet
    @bets.values.max
  end
  
  def reset_checks
    @players.map! { |player| player.check = false }
  end
  
  def take_amt(player, amt)
    if @bets.keys.include?(player)
      @bets[player] += amt
    else
      @bets[player] = amt
    end
    @pot += amt
  end
  
  def pay_out
    winner = nil
    ties = []
    0.upto(@bets.keys.count - 2) do |p1|
      (player1+1).upto(@bets.keys.count - 1) do |p2|
        if @bets[@bets.keys[p1]].beats?(@bets[@bets.keys[p2]])
          winner = p1
        elsif @bets[@bets.keys[p1]].beats?(@bets[@bets.keys[p2]]).nil?
          ties << p1
          ties << p2
        end
      end
    end
    if ties.empty?
      winner.pay_out(@pot)
    else
      ties.each do |player|
        player.pay_out(@pot / ties.count)
      end
    end
    @pot = 0
  end
end