def calculator(instructions)
  instructions = instructions.split
  stack = []
  operators = ["+", "-", "*", "/"]
  until instructions.empty?
    if operators.include?(instructions[0])
      stack = operate(stack, instructions[0])
      instructions.shift
    else      
      stack << instructions.shift.to_i 
    end
  end
  puts stack
end

def operate(stack, operator)
  num1 = stack.pop
  num2 = stack.pop
  if operator == "+"
    stack << num1 + num2
  elsif operator == "-"
    stack << num2 - num1
  elsif operator == "*"
    stack << num1 * num2
  else
    stack << num2 / num1
  end
  stack
end

def read_file
  puts "Submit file name"
  file_name = gets.chomp
  calculator(File.read(file_name).chomp)
end

def take_instructions
  puts "Submit instruction string"
  instructions = gets.chomp
  calculator(instructions)
end

def interface
  puts "Are you submitting a file [F] or string [S] of instructions?"
  choice = gets.chomp
  if choice == 'F'
    read_file
  elsif choice == 'S'
    take_instructions
  else
    puts 'Invalid choice!'
    interface
  end
end

if __FILE__ == $PROGRAM_NAME
  interface
end