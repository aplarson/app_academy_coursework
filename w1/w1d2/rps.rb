def rps(choice)
  rps_array = ["Rock", "Paper", "Scissors"]
  if valid_throw?(choice, rps_array)
    comp_choice = rps_array.sample
    if choice == comp_choice
      result = "Draw"
    elsif won?(choice, comp_choice)
      result = "Win"
    else
      result = "Lose"
    end
  else
    print "Not a valid move"
  end
  print [comp_choice, result]
end

def won?(choice, comp_choice)
  (choice == 'Rock' && comp_choice == 'Scissors') ||
  (choice == 'Scissors' && comp_choice == 'Paper') ||
  (choice == 'Paper' && comp_choice == 'Rock')
end

def valid_throw?(choice, throw_array)
  throw_array.include?(choice)
end

rps(gets.chomp)