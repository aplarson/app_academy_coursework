class Array
  def my_each(&prc)
    i = 0
    while i < self.length
      prc.call(self[i])
      i += 1
    end
    self
  end
  
  def my_map(&prc)
    mapped_array = []
    i = 0
    self.my_each do
      mapped_array <<  prc.call(self[i])
      i += 1
    end
    mapped_array
  end
  
  def my_select(&prc)
    selected = []
    i = 0
    self.my_each do
      if prc.call(self[i])
        selected <<  self[i]
      end
      i += 1
    end
    selected
  end
  
  def my_inject(&prc)
    accum = self[0]
    i = 1
    self[1..-1].my_each do 
      accum = prc.call(accum, self[i])
      p accum
      i += 1
    end
    accum
  end
  
  def my_sort!(&prc)
    sorted = false
    until sorted
      sorted = true
      i = 0
      while i < self.length - 1
        num1, num2 = self[i], self[i+1]
        if prc.call(num1, num2) == 1
          self[i], self[i+1] = num2, num1
          sorted = false
        end
        i += 1
      end
    end
    self
  end
  
  def my_sort(&prc)
    self.dup.my_sort!(&prc)
  end
end

def eval_block(*args, &proc)
  if block_given?
    proc.call(*args)
  else
    puts "NO BLOCK GIVEN"
  end
end