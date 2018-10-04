class Towers
  attr_accessor :piles, :winning_pile, :turns

  def initialize(num_discs=3)
    raise ArgumentError unless num_discs.is_a?(Integer) && num_discs > 0
    @winning_pile
    @piles = populate_piles(num_discs)
    @turns = 0
  end

  def populate_piles(num_discs)
    piles = Array.new(3){[]}

    num_discs.times do |i|
      piles[0].unshift(i + 1)
    end

    self.winning_pile = piles[0]

    piles
  end

  def move(start_pile, end_pile)

    raise 'Piles not valid' unless start_pile.is_a?(Integer) && end_pile.is_a?(Integer)
    raise 'Piles do not exist' unless start_pile.between?(0,2) && end_pile.between?(0,2)
    raise 'Piles cannot be the same' if start_pile == end_pile
    raise 'No discs at start pile' if self.piles[start_pile].empty?

    if self.piles[end_pile].empty? || self.piles[end_pile].last > self.piles[start_pile].last
      self.piles[end_pile] << self.piles[start_pile].pop
    else
      raise 'Cannot move larger disc onto smaller disc'
    end
    self.piles
  end

  def won?
    piles[1] == self.winning_pile || piles[2] == self.winning_pile
  end

  def render
    self.piles.each_with_index do |pile, idx|
      str = "Pile #{idx + 1}: "
      pile.each do |disc|
        str += "#{disc} "
      end
      puts str
    end
  end

  def play
    until won?
      system("clear")
      render
      begin
        start_pile, end_pile = gets_input
        move(start_pile, end_pile)
      rescue
        retry
      end
      self.turns += 1
    end

    puts "Nice. Only took you #{self.turns} turns."
  end

  def gets_input
    begin
      puts "Enter the pile to take a disc from:"
      start_pile = gets.chomp
      puts "Enter the pile to move the disc to:"
      end_pile = gets.chomp

      start_pile = Integer(start_pile) - 1
      end_pile = Integer(end_pile) - 1
    rescue
      retry
    end

    [start_pile, end_pile]
  end
end
