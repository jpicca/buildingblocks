class Board

	attr_accessor :board_arr, :code

	def initialize
		@board_arr = Array.new(48,"-")
		@board_keys = Array.new(48,"*")
		@code = Array.new(4,"-")
	end

	def show_board
		(0..11).each do |row|
			start = row*4
			puts "| #{@board_arr[start]} | #{@board_arr[start+1]} | #{board_arr[start+2]}"\
			" | #{board_arr[start+3]} |"\
			" keys: #{@board_keys[start]} #{@board_keys[start+1]} #{@board_keys[start+2]}"\
			" #{@board_keys[start+3]}"
		end
	end

	def assign_guess(arr, row)
		start = row*4
		finish = row*4 + 3
		@board_arr[start..finish] = arr
	end

	def key_generator(arr,row)
		start = row*4

		master_arr = Array.new(@code)
		answer_arr = Array.new(arr)

		4.times do |i|
			if answer_arr[i] == master_arr[i]
				@board_keys[start+i] = 2
				master_arr[i] = "-"
				answer_arr[i] = "*"
			end
		end

		4.times do |i|
			if master_arr.include?(answer_arr[i])
				@board_keys[start+i] = 1
				index = master_arr.index(answer_arr[i])
				master_arr[index] = "-"
			end
		end

		return @board_keys[start..(start+3)]
	end

end


class Player

#	def print_guess(arr)

#		puts "The guess is #{arr[0]}, #{arr[1]}, #{arr[2]}, #{arr[3]}"
		
#	end

#	def print_keys(arr)
		
#		arr.each { |n| puts n}
	
#	end

end


class Human < Player

	def human_crack
		arr = []
		puts "Crack dat code! Choose a number between 0 and 5 for each slot."
		4.times do |i|
			puts "For slot #{i}?"
			entry = gets.chomp
			arr.push(entry.to_i)
		end
		arr
	end

	def human_create
		arr = []
		puts "Create dat code! Choose a number between 0 and 5 for each slot."
		4.times do |i|
			puts "For slot #{i}?"
			entry = gets.chomp
			arr.push(entry.to_i)
		end
		arr
	end

end


class Computer < Player

	def comp_crack(keys,arr)
		puts "Guessing..."
		sleep(1)
		guess = Array.new(4)
		keys.each_with_index { |val,index| 
			if val == 2
				guess[index] = arr[index]
			else
				guess[index] = rand(0..5)
			end
		}
		
		guess
		#Array.new(4) { rand(0..5)}
	end

	def comp_create
		#Returns array of 4 random numbers b/w 0 & 5
		Array.new(4) { rand(0..5) }
	end

end


class Game

	attr_accessor :board

	def initialize
		@board = Board.new
		puts "Welcome to the dumb game of Mastermind!"

		player_choice
		@human = Human.new
		@comp = Computer.new

		@choice == 1 ? gameplay_comp : gameplay_player

	end

	def player_choice
		puts "Human, would you like to create the code (1) or crack the code (2)?"
		@choice = gets.chomp.to_i

		#Check if entry is valid (either a 1 or 2)
		if ![1,2].include?(@choice)
			"Invalid! Choose 1 or 2 idiot"
			player_choice
		end
	end

	#Player cracks the code
	def gameplay_player
		@board.code = @comp.comp_create
		12.times do |i|
			arr = @human.human_crack
			@board.assign_guess(arr,i)
			@board.key_generator(arr,i)
			@board.show_board
			
			if arr == @board.code 
				puts "You cracked it!" 
				break
			else
				puts i < 11 ? "Nope, try again" : "You couldn't crack it! YOU LOSE"
			end

		end
	end

	#Comp cracks the code
	def gameplay_comp
		@board.code = @human.human_create

		comp_keys = Array.new(4)
		arr = Array.new(4)

		#Computer guesses
		12.times do |i|
			arr = @comp.comp_crack(comp_keys,arr)
			@board.assign_guess(arr,i)
			comp_keys = @board.key_generator(arr,i)
			@board.show_board

			if arr == @board.code 
				puts "Computer cracked it!" 
				break
			else
				puts i < 11 ? "Nope, next guess..." : "Computer couldn't crack it!"
			end
		end
	end

end

Game.new
