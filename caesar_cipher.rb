puts "Hey gimme dat cipher string!"

string = gets.chomp

chars = string.split('')

puts "How much you wanna shift it?"

shift = gets.chomp

chars.map! {|s|

	index = chars.index(s)

	#Initial check to see if character is an alpha; if not, we do nothing to it
	#Check for alpha character
	if s =~ /[a-zA-Z]/
		#Do this to wrap a-z back on itself (a: 97 .. z: 122)
		if (s.ord + shift.to_i) > 122 && s =~ /[a-z]/		
			remainder = (s.ord + shift.to_i - 123) % 26 
			(97 + remainder).chr
			#puts chars[index]
		#Do this to wrap A-Z back on itself (a: 65 .. z: 90)
		elsif (s.ord + shift.to_i) > 90 && s =~ /[A-Z]/
			remainder = (s.ord + shift.to_i - 91) % 26
			(65 + remainder).chr
			#puts chars[index]
		else
		    (shift.to_i + s.ord).chr
		    #puts chars[index]
		end
	else
		s
	end
	#puts index, chars[index], s
}

puts "Your Caesar Cipher is " + chars.join("")