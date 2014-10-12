def range(start_num, end_num)  
  if end_num < start_num
    return []
  elsif start_num == end_num
    return [start_num]
  end
  [start_num] + range(start_num + 1, end_num)
end

def sum_of_an_array(array)
  sum = 0
  array.each do |i|
    sum += i
  end
  sum
end

def recursive_sum(array)
  return array[0] if array.length == 1
  array[0] + recursive_sum(array[1..-1])
end

def exp1(n,exp)
  return 1 if exp == 0
  return n if exp == 1
  n * exp1(n,exp-1)
end

def exp2(n, exp)
  return 1 if exp == 0
  return n if exp == 1
  if exp % 2 == 0
    exp2(n, exp / 2) * exp2(n, exp / 2)
  else
    n * (exp2(n, ((exp - 1) / 2)) * exp2(n, ((exp - 1) / 2)))
  end
end

class Array
  def deep_dup
    duplicate = []
    self.each do |el|
      if el.is_a?(Array)
        duplicate << el.deep_dup
      else
        duplicate << el
      end
    end
    duplicate
  end
end

def iterative_fibs(n)
  return [0] if n == 1
  return [0, 1] if n == 2
  fibs = [0, 1]
  (n - 2).times do
    fibs << fibs[-1] + fibs[-2]
  end
  fibs
end

def recursive_fibs(n)
  return [0] if n == 1
  return [0, 1] if n == 2
  fib_array = recursive_fibs(n - 1)
  fib_array << fib_array[-1] + fib_array[-2]
end

def bsearch(array,target)
  half = array.length / 2
  comparison = array[half] <=> target
  case comparison
  when 1
    bsearch(array[0...half], target)
  when -1
    search = bsearch(array[(half + 1)..-1], target)
    return nil unless search
    (half + 1) + search
  when 0
    return half
  else
    nil
  end
end

def make_change(change, val_coins) # Only works if change is divisible by the smallest coin
  return [] unless val_coins.length > 0
  max = change / val_coins[0]
  cases = []
  (0..max).each do |num_coins|
    leftovers = change - (num_coins * val_coins[0])
    my_change = []
    num_coins.times {my_change << val_coins[0]}
    return my_change if leftovers == 0
    cases << my_change + make_change(leftovers, val_coins[1..-1])
  end
  p cases
  cases.sort_by { |coins| coins.length }.first
end

class Array
  def merge_sort
    return [] if self.length == 0
    return self if self.length == 1
    left = self[0..((self.length / 2) - 1)]
    right = self[(self.length / 2)..-1]
    (left.merge_sort).merge(right.merge_sort)
  end
  
  def merge(comp_arr)
    merged_array = []
    until self.empty? || comp_arr.empty?
      if self[0] < comp_arr[0]
        merged_array << self.shift
      else
        merged_array << comp_arr.shift
      end
    end
    merged_array + self + comp_arr
  end
  
  def subsets
    return [[]] if self.empty?
    subs = self[0...-1].subsets    
    (0...subs.length).each { |i| subs << (subs[i].dup << self[-1]) }
    subs
  end
end