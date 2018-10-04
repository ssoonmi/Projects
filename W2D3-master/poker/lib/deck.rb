require_relative 'card'

class Deck
  attr_reader :cards

  def initialize
    @cards = populate_cards
  end

  def populate_cards
    cards = []
    values = (1..13).to_a
    suits = [:hearts, :clubs, :diamonds, :spades]

    values.each do |value|
      suits.each do |suit|
        cards << Card.new(value, suit)
      end
    end

    cards
  end

  def shuffle!
    self.cards.shuffle!
  end

  private
  attr_writer :cards
end
