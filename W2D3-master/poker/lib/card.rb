class Card
  attr_reader :value, :suit

  def initialize(value, suit)
    values = (1..13).to_a
    suits = [:hearts, :clubs, :diamonds, :spades]

    raise 'Invalid value' unless values.include?(value)
    raise 'Invalid suit' unless suits.include?(suit)
    @value = value
    @suit = suit
  end
end
