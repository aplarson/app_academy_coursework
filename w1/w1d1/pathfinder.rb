maze = []

File.open(gets.chomp).each_line{ |s| maze << s.split('') }

def closed_square?(val)
  val == "X" || val == "*"
end

def starting_position(maze)
  maze.each_with_index do |row, row_idx|
    if row.include?("S")
      return [row_idx, row.index("S")]
    end
  end
end

def generate_moves(square)
  [[square[0] - 1, square[1]], [square[0], square[1] + 1], 
  [square[0] + 1, square[1]], [square[0], square[1] - 1] ]
end

def breadth_first(maze) # This is hilariously wrong
  start_node = starting_position(maze)
  queue = [start_node]
  while queue.length > 0
    current_parent = queue.pop
    maze[current_parent[0]][current_parent[1]] = "X"
    generate_moves(current_parent).each do |node|
      val = maze[node[0]][node[1]]
      if val == "E"
      end
      queue << node unless closed_square?(val)
      p queue
    end
  end
end

breadth_first(maze)