def super_print(word, options = {})
  
  defaults = {
    :times => 1,
    :upcase => false,
    :reverse => false
  }
  
  options = defaults.merge(options)
  
  word = word.upcase if options[:upcase]
  word = word.reverse if options[:reverse]
  
  options[:times].times { print word } 
end

super_print("Hello", :times => 3)
super_print("Hey Baby")
super_print("Como Esta?", :times => 2, :upcase => true, :reverse => true)