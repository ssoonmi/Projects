class Array

  def my_uniq
    uniq_arr = []
    self.each { |el| uniq_arr << el unless uniq_arr.include?(el) }
    uniq_arr
  end

  def two_sum
    result_arr = []
    self.each_with_index do |el1, idx1|
      self[(idx1 + 1)..-1].each_with_index do |el2, idx2|
        idx2 = idx2 + idx1 + 1
        result_arr << [idx1, idx2] if el1 + el2 == 0
      end
    end
    result_arr
  end

  def my_transpose
    return [] if self.empty?

    transposed_arr = Array.new(self[0].length) {Array.new}

    self.each_with_index do |row, row_idx|
      raise ArgumentError.new("Array cannot be transposed") unless row.length == self[0].length
      row.each_with_index do |el, col_idx|
        transposed_arr[col_idx][row_idx] = el
      end
    end

    transposed_arr
  end

end

def stock_picker(prices)
  max_profit = 0
  indices = []

  prices.each_with_index do |first_price, idx1|
    prices[idx1+1..-1].each_with_index do |sec_price, idx2|
      next if sec_price <= first_price || max_profit >= (sec_price - first_price)
      idx2 = idx2 + idx1 + 1
      indices = [idx1, idx2]
      max_profit = sec_price - first_price
    end
  end

  indices
end
