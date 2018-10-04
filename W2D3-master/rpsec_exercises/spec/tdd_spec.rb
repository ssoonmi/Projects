# require 'rspec'
require 'tdd'
require 'towers'

describe "#my_uniq" do
  it "returns an empty array if given empty array" do
    expect([].my_uniq).to eq([])
  end

  it "returns a new array" do
    arr = [1,2,1,3,3]
    expect(arr.my_uniq).to_not be(arr)
  end

  it "returns an array of unique elements" do
    arr = [1,2,1,3,3]
    expect(arr.my_uniq).to eq([1,2,3])
  end

  it "returns elements in order that they appear" do
    arr = [2,1,2,3,3]
    expect(arr.my_uniq).to eq([2,1,3])
  end
end

describe "#two_sum" do
  it "returns empty array if given empty array" do
    expect([].two_sum).to eq([])
  end

  it "returns pairs of positions where elements at those positions sum to zero" do
    expect([-1,0,2,-2,1].two_sum).to eq( [[0,4],[2,3]] )
  end

  it "returns pairs with smaller index before bigger index" do
    expect([-2,0,1,2,2].two_sum).to eq( [[0,3],[0,4]] )
  end

  it "only checks the sum of pairs, not more than two elements" do
    expect([-2,0,1,1,2,2].two_sum).to eq( [[0,4],[0,5]] )
  end
end

describe "#my_transpose" do
  it "returns empty array if given empty array" do
    expect([].my_transpose).to eq([])
  end

  it "raises an error if all subarrays are not equal in length" do
    rows = [[0,1,2],[3,4]]
    expect {rows.my_transpose}.to raise_error(ArgumentError, "Array cannot be transposed")
  end

  it "does not call Array#transpose" do
    rows = [[0,1,2],[3,4,5]]
    expect(rows).to_not receive(:transpose)
    rows.my_transpose
  end

  it "returns array with length of all sub-arrays equal to length of given array" do
    rows = [[0,1,2],[3,4,5]]
    expect(rows.my_transpose[0].length).to eq(2)
    expect(rows.my_transpose[1].length).to eq(2)
    expect(rows.my_transpose[2].length).to eq(2)
  end

  it "returns a correctly transposed array" do
    rows = [[0, 1, 2],[3, 4, 5],[6, 7, 8]]
    cols = [[0, 3, 6],[1, 4, 7],[2, 5, 8]]

    expect(rows.my_transpose).to eq(cols)
    expect(cols.my_transpose).to eq(rows)
  end
end

describe "#stock_picker" do

  it "returns the pair of days with the maximum profit" do
    prices = [3.86, 5, 2.17, 7.10]
    expect(stock_picker(prices)).to eq([2,3])
  end

  it "returns earliest pair of days with maximum profit" do
    prices = [3.86, 8.79, 2.17, 7.10]
    expect(stock_picker(prices)).to eq([0,1])
  end

  it "returns empty array if no profit is available" do
    prices = [8.79, 7.10, 3.86, 2.17]
    expect(stock_picker(prices)).to be_empty
  end

end


describe Towers do
  subject(:tower) {Towers.new}

  describe "#initialize" do
    it "can take an argument for number of discs" do
      expect{Towers.new(6)}.to_not raise_error
    end

    it "argument has a default value" do
      expect{Towers.new}.to_not raise_error
    end

    it "builds a starting towers with correct number of discs" do
      expect(tower.piles[0].length).to eq(3)
      expect(tower.piles.length).to eq(3)
      expect(tower.piles[1].length).to eq(0)
      expect(tower.piles[2].length).to eq(0)
    end

    it "builds first pile with correct disc order (descending size order)" do
      expect(tower.piles[0]).to eq([3,2,1])
    end

    it "raises an error if argument is not a positive integer" do
      expect{Towers.new(-2)}.to raise_error(ArgumentError)
      expect{Towers.new('2')}.to raise_error(ArgumentError)
    end
  end

  describe "#move" do
    before {tower.move(0, 1)}

    it "doesn't allow bigger disc to move onto smaller disc" do
      expect {tower.move(0, 1)}.to raise_error('Cannot move larger disc onto smaller disc')
    end

    it "allows any disc to go into an empty pile" do
      expect(tower.piles).to eq([[3,2],[1],[]])
    end

    it "allows smaller disc to be placed on top of bigger disc" do
      tower.move(1,0)
      expect(tower.piles).to eq([[3,2,1],[],[]])
    end

    it "doesn't move from an empty pile" do
      expect {tower.move(2,1)}.to raise_error('No discs at start pile')
    end

    it "raises an error if start and end piles are the same" do
      expect {tower.move(1,1)}.to raise_error('Piles cannot be the same')
    end

    it "raises an error if pile indices are off the board" do
      expect {tower.move(4,1)}.to raise_error('Piles do not exist')
      expect {tower.move(0,4)}.to raise_error('Piles do not exist')
      expect {tower.move(-1,3)}.to raise_error('Piles do not exist')
    end

    # it "raises error if not given an integer" do
    #   # expect {tower.move(:weird, 1)}.to raise_error('Piles not valid')
    #   # expect {tower.move(1, "one")}.to raise_error('Piles not valid')
    #   # expect {tower.move(1, "3")}.to raise_error('Piles not valid')
    # end
  end

  describe "#won?" do
    it "returns true for a winning board" do
      tower.piles = [[],[3,2,1],[]]
      expect(tower.won?).to be true

      tower.piles = [[],[],[3,2,1]]
      expect(tower.won?).to be true
    end

    it "returns false for a non-winning board" do
      expect(tower.won?).to be false
      tower.move(0,1)
      expect(tower.won?).to be false
    end
  end

  describe

end
