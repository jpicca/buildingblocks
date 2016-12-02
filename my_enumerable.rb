module Enumerable
	
	def my_each
		return enum_for(:my_each) unless block_given?
		
		#Need this if/else block to see if object is array or enum
		if self.class == Range
			for i in self.first..self.last
				yield i
			end
		else
			for i in 0...self.length
				yield(self[i])
			end
		end
		#self
	end

	def my_each_with_index
		return enum_for(:my_each_with_index) unless block_given?
		for i in 0...self.length
			yield(self[i], i)
		end
	end

	def my_select
		return enum_for(:my_each) unless block_given?
		new_array = []
		self.my_each { |x|
			new_array << x if yield(x)	#for a select method, the block returns true/false
		}
		return new_array
	end

	def my_all?
		tf = true
		if !block_given?				#all? uses implicit block of {|x| x if no block is specified}
			self.my_each { |x| 
				tf = false if !x
			}
		else
			self.my_each { |x|
				tf = false if !yield(x)
			}
		end
		return tf
	end

	def my_any?
		tf = false
		if !block_given?
			self.my_each { |x|
				tf = true if !!x		#One ! to convert to boolean, then another ! to return to its
			}							#original boolean value (e.g. !!3 = !false = true)
		else
			self.my_each { |x|
				tf = true if !!yield(x)
			}
		end
		return tf
	end

	def my_none?
		tf = true
		if !block_given?
			self.my_each { |x|
				tf = false if !!x
			}
		else
			self.my_each { |x|
				tf = false if !!yield(x)
			}
		end
		return tf
	end

	def my_count(arg=nil)
		count = 0
		if !block_given?
			if arg == nil
				count = self.length
			else
				self.my_each { |x|
					count += 1 if arg == x
				}
			end
		else	#block given
			self.my_each { |x|
				count += 1 if yield(x)
			}
		end
		return count
	end

	# old my_map that just accepts blocks
	# def my_map
	# 	return enum_for(:my_each) unless block_given?
	# 	new_array = []
	# 	self.my_each { |x| 
	# 		new_array << yield(x)
	# 	}
	# 	return new_array
	# end

	def my_map(&proc)
		new_array = []
		if proc
			self.my_each { |x| new_array << proc.call(x) }
		else
			self.my_each { |x| new_array << yield(x) }
		end
		return new_array
	end

	def my_inject(init = nil)
		if init.nil?
			memo = self.first
			self.shift			#remove first element since it becomes the memo
			self.my_each { |x| memo = yield(memo,x) }
		else
			memo = init
			self.my_each { |x| memo = yield(memo,x) }
		end
		memo
	end

end

def multiply_els(array)
	array.my_inject { |total, x| total*x }
end

