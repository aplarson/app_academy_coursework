def bubble_sort(array)
  switched = true
  while switched
    switched = false
    (0...array.length - 1).each do |idx|
      if array[idx] > array[idx + 1]
        array[idx], array[idx + 1] = array[idx + 1], array[idx]
        switched = true
      end
    end
  end
  array
end

print bubble_sort([6, 5, 3, 2])