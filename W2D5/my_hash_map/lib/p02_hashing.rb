class Fixnum
  # Fixnum#hash already implemented for you
end

class Array
  def hash
    arr_hash = 1019017204321920079
    self.each_with_index do |el, idx|
      arr_hash += (el.hash * (idx.hash * idx.hash))
    end
    until arr_hash.abs <= 10**18
      arr_hash = arr_hash/10
    end
    arr_hash
  end
end

class String
  def hash
    return 0.hash if self.length < 1
    return self.ord if self.length == 1
    arr = self.split("")
    arr.hash
  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    hash_hash = -463569212425351025
    self.each do |key, value|
      hash_hash += (key.hash * (value.hash % 9))
    end
    until hash_hash.abs <= 10**18
      hash_hash = hash_hash/10
    end
    hash_hash
  end
end
