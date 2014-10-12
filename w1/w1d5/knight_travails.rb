class KnightPathFinder
  
  POSSIBLE_MOVES =  [[2,1], [2,-1], [1, -2], [1,2],[-1, -2], 
                     [-1, 2],[-2, 1], [-2,-1]]
  
  def initialize(start_pos)
    @start_pos = start_pos
    @visited_positions = [start_pos]
  end
  
  def self.valid_moves(pos)
    valid_moves = POSSIBLE_MOVES.map do |move|
      [(move[0] + pos[0]), (move[1] + pos[1])]
    end
    
    valid_moves.select! do |move|
      (move[0] < 8 && move[0] >= 0) && (move[1] < 8 && move[1] >= 0)
    end
    
    valid_moves
  end
  
  def new_move_positions(pos)
    new_moves = KnightPathFinder.valid_moves(pos).
      delete_if { |candidate| @visited_positions.include?(candidate) }
    @visited_positions += new_moves
    new_moves
  end
  
  def build_move_tree
    move_tree = [PolyTreeNode.new(@start_pos)]
    master_queue = [move_tree[0]]
    until master_queue.empty?
      current_node = master_queue.shift
      new_moves = new_move_positions(current_node.value).map do |pos|
        new_node = PolyTreeNode.new(pos)
        new_node.parent = current_node
        new_node
      end
      master_queue += new_moves
      move_tree += new_moves
    end
    move_tree
  end
  
  def find_path(end_pos)
    move_tree = self.build_move_tree
    final_node = move_tree[0].dfs(end_pos)
    final_node.trace_path_back
  end
  
end

class PolyTreeNode
  attr_accessor :children, :value, :parent
  
  def initialize(value)
    @parent = nil
    @children = []
    @value = value
  end
  
  def parent=(parent_val)
    @parent.children.delete(self) unless @parent.nil?
    @parent = parent_val 
    (@parent.children << self).uniq! unless @parent.nil?
  end
  
  def add_child(child)
    child.parent = self
  end
  
  def remove_child(child)
    raise "Not a child" unless self.children.include?(child)
    child.parent = nil 
  end
  
  def dfs(value)
    return self if value == self.value
    
    @children.each do |child|
      search = child.dfs(value)
      return search unless search == nil
      
    end
    nil
  end  
    
  def bfs(value)
    master_queue = [self]
    until master_queue.empty?
      current_node = master_queue.shift 
      return current_node if value == current_node.value
      master_queue += current_node.children
    end
    nil
  end
  
  
  def trace_path_back
    return [self.value] if self.parent.nil?
    self.parent.trace_path_back << self.value
  end
  
end

