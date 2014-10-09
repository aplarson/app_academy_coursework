class MyHashSet
  def initialize
    @store = {}
  end
  
  def insert(el)
    @store[el] = true
  end
  
  def include?(el)
    @store[el] == true
  end
  
  def delete(el)
    value_deleted = false
    if @store.keys.include?(el)
      @store.delete(el)
      value_deleted = true
    end
    value_deleted
  end
  
  def to_a
    @store.keys
  end
  
  def union(set2)
    united_set = MyHashSet.new
    self.to_a.each do |el|
      united_set.insert(el)
    end
    set2.to_a.each do |el|
      united_set.insert(el)
    end
    united_set
  end
  
  def intersect(set2)
    intersection = MyHashSet.new
    self.to_a.each do |el|
      if set2.include?(el)
        intersection.insert(el)
      end
    end
    intersection
  end
  
  def minus(set2)
    exclusive_set = MyHashSet.new
    self.to_a.each do |el|
      exclusive_set.insert(el)
    end
    set2.to_a.each do |el|
      exclusive_set.delete(el)
    end
    exclusive_set
  end
end

new_hash_set = MyHashSet.new
another_hash_set = MyHashSet.new
new_hash_set.insert("Hello")
puts new_hash_set.include?("Hello")
puts new_hash_set.to_a
new_hash_set.insert("Goodbye")
another_hash_set.insert("Hello")
another_hash_set.insert("Bonjour")
puts new_hash_set.union(another_hash_set).to_a
puts new_hash_set.intersect(another_hash_set).to_a
puts new_hash_set.minus(another_hash_set).to_a