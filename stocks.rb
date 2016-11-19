prices = Array.new(20) { rand(20) }
#prices = [5, 12, 13, 4, 3,4, 6, 10, 12, 18, 16]

combos = Hash.new(0)

prices.each_with_index do |price, index|
	for i in (index+1)..(prices.length-1)
		price_diff = prices[i] - price
		combos[[index,i]] = price_diff
	end
end

puts prices

max =  combos.values.max

puts "You should have bought on Day... " + combos.key(max)[0].to_s
puts "And you should have sold on Day... " + combos.key(max)[1].to_s
puts "You would have profited... $" + max.to_s