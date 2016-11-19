dictionary = ["below","down","go","going","horn","how","howdy","it","i","low","own","part","partner","sit"]

string = "Howdy partner, sit down! How's it going?"
string_arr = string.split(" ")

counts = Hash.new(0)

dictionary.each do |substring|
	string_arr.each do |word|
		if word.downcase =~ /#{substring}/
			counts[substring] += 1
		end
	end
end

puts string_arr
puts counts