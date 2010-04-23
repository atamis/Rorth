#       This program is free software; you can redistribute it and/or modify
#       it under the terms of the GNU General Public License as published by
#       the Free Software Foundation; either version 2 of the License, or
#       (at your option) any later version.
#       
#       This program is distributed in the hope that it will be useful,
#       but WITHOUT ANY WARRANTY; without even the implied warranty of
#       MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#       GNU General Public License for more details.
#       
#       You should have received a copy of the GNU General Public License
#       along with this program; if not, write to the Free Software
#       Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
#       MA 02110-1301, USA.

module Rorth
	
	# A class to implement a few built in words. Documentation should be included.
	class BuiltinWords
		def initialize
		
		end
		
		# Meta stuff. Next question
		
		# Add a carrage return. "\n"
		def cr stack, tmp
			puts
		end
		
		# Print the first item on the stack after converting it to a string. Does not consume.
		def p stack, tmp
			print stack[0].to_s
		end
		
		# Consumes the first item in the stack and places it in the tmp variable.
		def tmpg stack, tmp
			tmp = stack.shift
			stack
		end
		
		# Places the current tmp variable in the stack. Does not destroy the item in the tmp variable.
		def tmpp stack, tmp
			stack.unshift tmp
		end
		
		# Copy the first item on the stack.
		def dup stack, tmp
			stack.unshift stack[0]
		end
		
		# Exit the program.
		def quit stack, tmp
			exit
		end
		
		# Delete the first item on the stack. Consumes. Obviously.
		def pop stack, tmp
			stack.shift
			stack
		end
		
		# Logic
		
		# Logical AND
		def and stack, tmp
			a = stack.shift
			b = stack.shift
			stack.unshift a && b
		end
		
		# Logical OR
		def or stack, tmp
			a, b = stack.shift, stack.shift
			stack.unshift a || b
		end
		
		# Inverter
		def not stack, tmp
			stack.unshift !stack.shift
		end
		
		# Mathematical stuff
		
		# Adds. Consumes.
		def + stack, tmp
			a = stack.shift
			b = stack.shift
			stack.unshift a + b
		end
		
		# Subtracts. Consumes.
		def - stack, tmp
			a = stack.shift
			b = stack.shift
			stack.unshift a - b
		end
		
		# Multipies. Consumes
		def * stack, tmp
			a, b = stack.shift, stack.shift
			stack.unshift a * b
		end
		
		# Divides. Consumes.
		def / stack, tmp
			a, b = stack.shift, stack.shift
			stack.unshift a / b
		end
		
		# Conditionals
		
		# Conditional equals. Does not consume. Note, defined using # # the define_method method, because you can't define a method # using "def" called "="
		define_method("=".to_sym) do |stack, tmp|
			stack.unshift stack[0] == stack[1]
			stack
		end
		
		
		# Greater than. Does not consume.
		def > stack, tmp
			stack.unshift stack[0] > stack[1]
			stack
		end
		
		# Less than. Does not consume
		def < stack, tmp
			stack.unshift stack[0] < stack[1]
			stack
		end
	end
end
