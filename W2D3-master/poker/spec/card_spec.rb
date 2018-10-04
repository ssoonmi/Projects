require 'card'

describe Card do
  describe '#initialize' do
    it 'raises error if invalid value' do
      expect {Card.new(15, :hearts)}.to raise_error('Invalid value')
    end

    it 'raises error if invalid suit' do
      expect {Card.new(12, :heart)}.to raise_error('Invalid suit')
    end

    subject(:queen_hearts) {Card.new(12, :hearts)}

    it 'initializes with a value' do
      expect(queen_hearts.value).to eq(12)
    end

    it 'initializes with a suit' do
      expect(queen_hearts.suit).to eq(:hearts)
    end

  end

end
