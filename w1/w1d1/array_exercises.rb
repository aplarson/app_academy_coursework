class Array
  def my_uniq
    unique_elements = []
    self.each do |element|
      next if unique_elements.include?(element)
      unique_elements << element
    end
    unique_elements
  end
  
  def two_sum
    zero_sums = []
    self.each_index do |first_index|
      ((first_index + 1)...self.length).each do |second_index|
        if (self[first_index] + self[second_index]) == 0
          zero_sums << [first_index, second_index]
        end
      end
    end
    zero_sums
  end
end

def my_transpose(matrix)
  column_matrix = []
  column_number = 0
  (0...matrix.length).each do |column_number|
    column = []
    matrix.each do |row|
      column << row[column_number]
    end
    column_matrix << column
  end
  column_matrix
end

def stock_picker(prices)
  most_profitable_dates = []
  max_profit = 0
  prices.each_index do |buy_date|
    (buy_date...prices.length).each do |sell_date|
      profit = prices[sell_date] - prices[buy_date]
      if profit > max_profit
        most_profitable_dates = [buy_date, sell_date]
        max_profit = profit
      end
    end
  end
  puts "To make the most profit, you should buy on day #{most_profitable_dates[0]} and sell on day #{most_profitable_dates[1]}"
end