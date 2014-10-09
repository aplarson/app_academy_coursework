def weird_number_loop
  number = 251
  until number % 7 == 0
    number += 1
  end
  p number
end

weird_number_loop