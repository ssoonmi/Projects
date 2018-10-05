require_relative 'p05_hash_map'
require_relative 'p04_linked_list'

class LRUCache
  attr_accessor :max, :prc, :store, :map

  def initialize(max, prc)
    @map = HashMap.new
    @store = LinkedList.new
    @max = max
    @prc = prc
  end

  def count
    @map.count
  end

  def get(key)
    if self.map.include?(key)
      node = self.map.get(key)
      update_node!(node)
    else
      if count == self.max
        eject!
      end

      calc!(key)
    end
  end

  def to_s
    'Map: ' + @map.to_s + '\n' + 'Store: ' + @store.to_s
  end

  private

  def calc!(key)
    # suggested helper method; insert an (un-cached) key

    cache = prc.call(key)

    new_node = self.store.append(key, cache)
    self.map.set(key, new_node)

    return cache
  end

  def update_node!(node)
    # suggested helper method; move a node to the end of the list
    val = self.store.get(node.key)

    self.store.remove(node.key)
    new_node = self.store.append(node.key, val)
    self.map.set(node.key, new_node)

    return node.val
  end

  def eject!
    node = self.store.head.next
    self.store.remove(node.key)
    self.map.delete(node.key)
  end
end
