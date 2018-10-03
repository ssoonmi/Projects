class MinesweeperGame
  attr_reader :player
  
  def self.make_default_game
    MinesweeperGame.new(player, [9,9])
  end

  def initialize(player, grid_size)
    @player = player
  end

  def run
    until solved?
      play_turn
    end
  end


end

class Board


end
