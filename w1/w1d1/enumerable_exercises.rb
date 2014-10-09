def doubler(numbers)
  numbers.map { |num| num * 2 }
end

class Array
  def my_each(&prc)
    idx = 0
    while idx < self.length
      prc.call(self[idx])
      idx += 1
    end
    self
  end
end

def median_finder(integers)
  sorted_integers = integers.sort
  number_of_integers = integers.count
  median = sorted_integers[number_of_integers / 2]
  if number_of_integers % 2 == 0
    median = ((median / 2) + (sorted_integers[(number_of_integers / 2) + 1])) / 2
  end
  median
end

def concatenate(strings)
  strings.inject("") { |concat, string| concat + string }
end


puts median_finder([2, 3, 1])
puts median_finder([3, 2, 4, 1])
puts concatenate(["Yay ", "for ", "strings!"])