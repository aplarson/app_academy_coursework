def remix(ingredients)
  alcohols = []
  mixers = []
  remixed_ingredients = []
  ingredients.each do |pair|
    alcohols << pair[0]
    mixers << pair[1]
  end
  new_alc = alcohols.shuffle
  new_mix = mixers.shuffle
  ingredients.each_index do |index|
    remixed_ingredients << [new_alc[index], new_mix[index]]
  end
  remixed_ingredients
end

p remix([
  ["rum", "coke"],
  ["gin", "tonic"],
  ["scotch", "soda"]
])