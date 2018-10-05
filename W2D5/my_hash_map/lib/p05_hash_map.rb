require_relative 'p04_linked_list'

class HashMap
  attr_accessor :count, :store
  include Enumerable

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { LinkedList.new }
    @count = 0
  end

  def include?(key)
    list = bucket(key)
    list.include?(key)
  end

  def set(key, val)
    if bucket(key).include?(key)
      bucket(key).update(key,val)
    else
      resize! if self.count == num_buckets
      list = bucket(key)
      list.append(key, val)
      self.count += 1
      true
    end
  end

  def get(key)
    list = bucket(key)
    list.get(key)
  end

  def delete(key)
    list = bucket(key)
    list.remove(key)
    self.count -= 1
  end

  def each(&prc)
    self.store.each do |list|
      list.each do |node|
        prc.call(node.key, node.val)
      end
    end
    self.store
  end

  # uncomment when you have Enumerable included
  def to_s
    pairs = inject([]) do |strs, (k, v)|
      strs << "#{k.to_s} => #{v.to_s}"
    end
    "{\n" + pairs.join(",\n") + "\n}"
  end

  alias_method :[], :get
  alias_method :[]=, :set

  private

  def num_buckets
    @store.length
  end

  def resize!
    new_store = Array.new(num_buckets * 2) {LinkedList.new}

    self.store.each do |list|
      list.each do |node|
        new_modulo = node.key.hash % (num_buckets * 2)
        new_store[new_modulo].append(node.key, node.val)
      end
    end

    self.store = new_store
  end

  def bucket(key)
    # optional but useful; return the bucket corresponding to `key`
    modulo = key.hash % (num_buckets)
    store[modulo]
  end
end
