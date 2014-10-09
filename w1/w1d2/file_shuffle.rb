def interface
  puts "Please enter the name of the file you want shuffled"
  file_name = gets.chomp
  shuffled_lines = line_shuffle(file_name + ".txt")
  File.open("#{file_name}-shuffled.txt", "w") do |f|
    shuffled_lines.each do |line|
      f.puts line
    end
  end
end

def line_shuffle(file_name)
  File.readlines(file_name).shuffle
end

interface