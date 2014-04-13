class Game
  attr_accessor :pot, :deck, :turn, :bets
  
  def initialize
    @pot = 0
    @bets = {}
  end

  def player_turn
  end #player_turn
  
  #def 
  
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