require 'deck'

describe Deck do
  subject(:deck){Deck.new}

  describe '#initialize' do
    it 'contains exactly 52 cards' do
      expect(deck.cards.length).to eq(52)
    end

    it 'contains all cards' do
      value_hash = Hash.new(0)
      values = deck.cards.map do |card|
        value_hash[card.value] += 1
        card.value
      end

      suit_hash = Hash.new(0)
      suits = deck.cards.map do |card|
        suit_hash[card.suit] += 1
        card.suit
      end
      expect(value_hash.keys.length).to eq(13)
      expect(suit_hash.keys.length).to eq(4)
      expect(value_hash.values.all?{|value_count| value_count == 4}).to be true
      expect(suit_hash.values.all?{|suit_count| suit_count == 13}).to be true
    end

  end

  describe '#shuffle!' do
    it 'randomizes order of cards' do
      unshuffled_deck = deck.cards.dup
      deck.shuffle!
      expect(deck.cards).to_not eq(unshuffled_deck)
    end
  end
end
