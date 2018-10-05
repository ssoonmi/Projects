class MaxIntSet
  attr_accessor :max, :store

  def initialize(max)
    @max = max
    @store = Array.new(max + 1){false}
  end

  def insert(num)
    validate!(num)
    store[num] = true
  end

  def remove(num)
    store[num] = false
  end

  def include?(num)
    store[num] == true
  end

  private

  def is_valid?(num)
    num > 0 && num <= max
  end

  def validate!(num)
    raise 'Out of bounds' unless is_valid?(num)
  end
end


class IntSet
  attr_accessor :store

  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
  end

  def insert(num)
    self[num] << num
  end

  def remove(num)
    self[num].delete(num)
  end

  def include?(num)
    self[num].include?(num)
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
    modulo = num % num_buckets
    store[modulo]
  end

  def num_buckets
    @store.length
  end
end

class ResizingIntSet
  attr_accessor :store, :count

  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(num)
    return false if include?(num)
    resize! if self.count == num_buckets
    self[num] << num
    self.count += 1
    true
  end

  def remove(num)
    return false unless include?(num)
    self[num].delete(num)
    self.count -= 1
    true
  end

  def include?(num)
    self[num].include?(num)
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
    modulo = num % num_buckets
    store[modulo]
  end

  def num_buckets
    @store.length
  end

  def resize!
    new_store = Array.new(num_buckets * 2) {Array.new}

    self.store.each do |bucket|
      bucket.each do |num|
        new_modulo = num % (num_buckets * 2)
        new_store[new_modulo] << num
      end
    end

    self.store = new_store
  end
end
