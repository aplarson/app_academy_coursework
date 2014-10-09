def factors(number)
  candidate = 1
  factor_array = []
  while candidate <= number
    factor_array << candidate if number % candidate == 0
    candidate += 1
  end
  p factor_array
end

factors(2)
factors(10)
factors(17)