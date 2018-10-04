class Hand

  attr_reader :cards

  def initialize
    @cards = []
  end

  def add_card(card)
    # raise ArgumentError unless card.is_a?(Card)
    self.cards << card
  end

  def remove_card(index)
    # raise ArgumentError unless index.is_a?(Integer) && cards[index]
    self.cards.delete_at(index)
  end

  def pairs
    values = Hash.new(0)
    pair_values = []

    cards.each do |card|
      values[card.value] += 1
    end

    values.each do |value,count|
      pair_values << value if count == 2
    end

    pair_values
  end

  def three_kind
    values = Hash.new(0)
    threes_values = []

    cards.each do |card|
      values[card.value] += 1
    end

    values.each do |value,count|
      threes_values << value if count == 3
    end

    threes_values
  end

  def full_house?
    pairs.length == 1 && three_kind.length == 1
  end

  def straight
    values = []
    cards.each do |card|
      values << card.value
    end

    values.sort!

    return 1 if values == [1,10,11,12,13]

    starting_val = values[0]

    values.each_with_index do |value, idx|
      return nil unless (idx + values[0]) == value
    end
    values.last
  end

  protected

  attr_writer :cards
end
