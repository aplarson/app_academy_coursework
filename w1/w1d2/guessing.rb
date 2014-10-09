def number_game
  computer_choice = rand(1..100)
  guess = nil
  guess_counter = 0
  until guess == computer_choice
    puts "Please enter a number between 1 and 100"
    guess = gets.chomp.to_i
    guess_counter += 1
    if guess > computer_choice
      puts "Your guess is too high"
    else
      puts "Your guess is too low"
    end
  end
  puts "Your guess is correct"
  puts "You took #{guess_counter} guesses"
end

number_game