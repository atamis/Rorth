class BuiltinWords
	def initialize
	
	end
	
	def cr stack
		puts
	end
	
	def p stack
		print stack[0].to_s
	end
	
	def + stack
		a = stack.shift
		b = stack.shift
		stack.unshift a + b
	end
	
	def tmpg stack
		$tmp = stack.shift
		stack
	end
	
	def tempp stack
		stack.unshift $tmp
	end
	
	def - stack
		a = stack.shift
		b = stack.shift
		stack.unshift a - b
	end
	
	def dup stack
		stack.unshift stack[0]
	end
	
	def and stack
		a = stack.shift
		b = stack.shift
		stack.unshift a && b
	end
end