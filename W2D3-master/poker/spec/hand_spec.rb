require 'hand'

describe Hand do
  subject(:hand) {Hand.new}
  # pairs, 3-of-a-kind, 4-of-a-king, straight, flush
  let(:card1){double('Card', value: 10, suit: :hearts)}
  let(:card2){double('Card', value: 10, suit: :spades)}
  let(:card3){double('Card', value: 11, suit: :hearts)}
  let(:card4){double('Card', value: 11, suit: :spades)}
  let(:card5){double('Card', value: 11, suit: :clubs)}

  let(:card6){double('Card', value: 10, suit: :hearts)}
  let(:card7){double('Card', value: 11, suit: :hearts)}
  let(:card8){double('Card', value: 12, suit: :hearts)}
  let(:card9){double('Card', value: 13, suit: :hearts)}
  let(:card10){double('Card', value: 1, suit: :hearts)}


  describe '#initialize' do
    it 'initializes with no cards' do
      expect(hand.cards).to be_empty
    end
  end

  describe '#add_card' do
    # it 'raises error if argument is not a Card' do
    #   expect {hand.add_card([])}.to raise_error(ArgumentError)
    #   expect {hand.add_card(12)}.to raise_error(ArgumentError)
    #   expect {hand.add_card(12, :hearts)}.to raise_error(ArgumentError)
    #   expect {hand.add_card(:hearts)}.to raise_error(ArgumentError)
    # end

    it 'adds one card to its cards array' do
      hand.add_card(card1)
      expect(hand.cards).to eq([card1])
    end
  end

  describe '#remove_card' do
    # it 'raises an error if there is no card at that index' do
    #   expect{hand.remove_card(0)}.to raise_error(ArgumentError)
    #   hand.add_card(card1)
    #   expect{hand.remove_card(0)}.to_not raise_error(ArgumentError)
    # end
    it 'removes the card at the given index' do
      hand.add_card(card1)
      hand.remove_card(0)
      expect(hand.cards).to be_empty
    end
  end

  describe '#pairs' do
    it 'returns array of values for all pairs in hand' do
      expect(hand.pairs).to eq([])

      hand.add_card(card1)
      hand.add_card(card2)

      expect(hand.pairs).to eq([10])

      hand.add_card(card3)
      hand.add_card(card4)

      expect(hand.pairs).to eq([10,11])

      hand.add_card(card5)

      expect(hand.pairs).to eq([10])
    end
  end

  describe '#three_kind' do
    it 'returns array of values for three of a kind' do
      expect(hand.three_kind).to eq([])

      hand.add_card(card1)
      hand.add_card(card2)

      expect(hand.three_kind).to eq([])

      hand.add_card(card3)
      hand.add_card(card4)

      expect(hand.three_kind).to eq([])

      hand.add_card(card5)

      expect(hand.three_kind).to eq([11])
    end
  end

  describe '#full_house?' do
    it 'returns true if full house in hand and returns false otherwise' do
      expect(hand.full_house?).to be false

      hand.add_card(card1)
      hand.add_card(card2)

      expect(hand.full_house?).to be false

      hand.add_card(card3)
      hand.add_card(card4)

      expect(hand.full_house?).to be false

      hand.add_card(card5)

      expect(hand.full_house?).to be true
    end
  end

  describe '#straight' do
    it 'returns the highest value of a straight' do
      expect(hand.straight).to be_nil

      hand.add_card(card6)
      hand.add_card(card7)

      expect(hand.straight).to be_nil

      hand.add_card(card8)
      hand.add_card(card9)

      expect(hand.straight).to be_nil

      hand.add_card(card10)

      expect(hand.straight).to eq(1)
    end
  end

end
