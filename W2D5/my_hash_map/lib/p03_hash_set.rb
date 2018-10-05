class HashSet
  attr_accessor :count, :store

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(key)
    return false if include?(key)
    resize! if self.count == num_buckets
    self[key] << key
    self.count += 1
    true
  end

  def include?(key)
    self[key].include?(key)
  end

  def remove(key)
    return false unless include?(key)
    self[key].delete(key)
    self.count -= 1
    true
  end

  private

  def [](key)
    # optional but useful; return the bucket corresponding to `key`
    modulo = key.hash % num_buckets
    store[modulo]
  end

  def num_buckets
    @store.length
  end

  def resize!
    new_store = Array.new(num_buckets * 2) {Array.new}

    self.store.each do |bucket|
      bucket.each do |key|
        new_modulo = key.hash % (num_buckets * 2)
        new_store[new_modulo] << key
      end
    end

    self.store = new_store
  end
end
