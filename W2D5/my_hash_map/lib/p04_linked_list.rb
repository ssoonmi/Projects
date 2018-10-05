class Node
  attr_accessor :key, :val, :next, :prev

  def initialize(key = nil, val = nil)
    @key = key
    @val = val
    @next = nil
    @prev = nil
  end

  def to_s
    "#{@key}: #{@val}"
  end

  def remove
    # optional but useful, connects previous link to next link
    # and removes self from list.
  end
end

class LinkedList
  attr_reader :head, :tail
  include Enumerable

  def initialize
    @head = Node.new(nil, nil)
    @tail = Node.new(nil, nil)
    @head.next = @tail
    @tail.prev = @head
  end

  def [](i)
    each_with_index { |link, j| return link if i == j }
    nil
  end

  def first
    self.head.next
  end

  def last
    self.tail.prev
  end

  def empty?
    self.head.next == self.tail
  end

  def get(key)
    node = self.head.next
    while node != self.tail
      if node.key == key
        return node.val
      end
      node = node.next
    end
    nil
  end

  def include?(key)
    node = self.head.next
    while node != self.tail
      if node.key == key
        return true
      end
      node = node.next
    end
    false
  end

  def append(key, val)
    new_node = Node.new(key, val)
    new_node.prev = self.tail.prev
    self.tail.prev.next = new_node
    self.tail.prev = new_node
    new_node.next = self.tail
  end

  def update(key, val)
    node = self.head.next
    while node != self.tail
      if node.key == key
        node.val = val
        return true
      end
      node = node.next
    end
    false
  end

  def remove(key)
    node = self.head.next
    while node != self.tail
      if node.key == key
        prev_node = node.prev
        next_node = node.next
        prev_node.next = next_node
        next_node.prev = prev_node
        return true
      end
      node = node.next
    end
    false
  end

  def each(&prc)
    node = self.head.next
    while node != self.tail
      prc.call(node)
      node = node.next
    end
    self
  end

  # uncomment when you have `each` working and `Enumerable` included
  def to_s
    inject([]) { |acc, link| acc << "[#{link.key}, #{link.val}]" }.join(", ")
  end
end
