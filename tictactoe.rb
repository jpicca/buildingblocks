

class Board
	attr_accessor :board_arr

	@@winning_arr = [[0,1,2],[3,4,5],[6,7,8],[0,3,6],[1,4,7],[2,5,8],[0,4,8],[2,4,6]]

	def initialize
		@board_arr = Array.new(9, "-")
	end

	def show_board
		puts "-------------"
		puts "| #{@board_arr[0]} | #{@board_arr[1]} | #{@board_arr[2]} |"
		puts "-------------"
		puts "| #{@board_arr[3]} | #{@board_arr[4]} | #{@board_arr[5]} |"
		puts "-------------"
		puts "| #{@board_arr[6]} | #{@board_arr[7]} | #{@board_arr[8]} |"
		puts "-------------"
	end

	def assign_to_cell(symbol, pos)
		@board_arr[pos] = symbol
		puts "#{symbol} placed in position #{pos}"
	end

	def valid_cell?(pos)
		@board_arr[pos.to_i] == "-"
	end

	def check_winner
		@@winning_arr.any? { |arr|
			#Check if all values are unique (X or O) and not equal to "-"
			([@board_arr[arr[0]],@board_arr[arr[1]],@board_arr[arr[2]]].uniq.length == 1) && 
				![@board_arr[arr[0]],@board_arr[arr[1]],@board_arr[arr[2]]].include?("-")
		}
	end

	def draw?
		!@board_arr.include?("-")
	end

end

class Player

	attr_accessor :symbol

	def initialize(symbol)
		#Player is X or O
		@symbol = symbol

	end

end

class Game

	attr_accessor :board, :player1, :player2

	def initialize
		@board = Board.new

		puts "Welcome to Tic-Tac-Toe!"
		puts "Player 1, what symbol would you like to be (X or O)?"
		@selection = gets.chomp

		#Won't let code past this point until valid symbol is given
		valid_symbol?

		@player1 = Player.new(@selection)
		@player2 = (@selection == "X" ? Player.new("O") : Player.new("X"))

		@player_arr = ["Player 1", "Player 2"]
		@player_sym_arr = [@player1.symbol,@player2.symbol]

		gameplay

	end

	def valid_symbol?
		if @selection == "X" || @selection == "O"
			return
		else
			puts "That ain't an X or O. What symbol you want?"
			@selection = gets.chomp

			#Keep calling valid_symbol? until a valid symbol is given
			valid_symbol?
		end
	end

	def gameplay

		puts "Here's the current board."
		@board.show_board

		get_player_input

		if @board.check_winner
			puts "#{@player_arr[0]} wins the game!"
			@board.show_board
		elsif @board.draw?
			puts "Boring! It's a draw!"
			@board.show_board
		else
			swap_players
			gameplay
		end
	end

	def swap_players
		@player_arr.reverse!
		@player_sym_arr.reverse!
	end

	def get_player_input
		puts "#{@player_arr[0]}, where would you like to place an #{@player_sym_arr[0]}?"
		pos = gets.chomp

		if @board.valid_cell?(pos)
			@board.assign_to_cell(@player_sym_arr[0], pos.to_i)
		else
			puts "You can't put an #{@player_sym_arr[0]} there!"
			get_player_input
		end
	end



end

Game.new
