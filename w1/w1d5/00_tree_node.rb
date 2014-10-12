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
end

