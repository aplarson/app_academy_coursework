def build_towers(num_disks)
  [(1..num_disks).to_a.reverse, [], []]
end

def display(towers)
  towers.each do |tower|
    print tower
  end
end

def get_tower(prompt)
  puts prompt
  tower = gets.chomp.to_i
  return tower if [1, 2, 3].include?(tower)
  get_tower(prompt)
end
  
def move(towers)
  tower_from = get_tower("Choose a tower to move from") - 1
  tower_to = get_tower("Choose a tower to move to") - 1
  if [1, 2, 3].include?(towers[tower_from].last) && 
    (towers[tower_to].empty? || towers[tower_to].last > towers[tower_from].last)
    towers[tower_to] << towers[tower_from].pop
  else
    puts "Please enter a valid move"
  end
  towers
end

def play(num_disks)
  towers = build_towers(num_disks)
  until won?(towers)
    display(towers)
    move(towers)
  end
  puts "You won!"
end

def won?(towers)
  towers[0].empty? && (towers[1].empty? || towers[2].empty?)
end

play(3)