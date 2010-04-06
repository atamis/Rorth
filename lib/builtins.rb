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
	class BuiltinWords
		def initialize
		
		end
		
		# Meta stuff. Next question
		def cr stack
			puts
		end
		
		def p stack
			print stack[0].to_s
		end
		
		def tmpg stack
			$tmp = stack.shift
			stack
		end
		
		def tempp stack
			stack.unshift $tmp
		end
		
		def dup stack
			stack.unshift stack[0]
		end
		
		# Logic
		def and stack
			a = stack.shift
			b = stack.shift
			stack.unshift a && b
		end
		
		def or stack
			a, b = stack.shift, stack.shift
			stack.unshift a || b
		end
		
		def not stack
			stack.unshift !stack.shift
		end
		
		# Mathematical stuff
		def + stack
			a = stack.shift
			b = stack.shift
			stack.unshift a + b
		end
		
		def - stack
			a = stack.shift
			b = stack.shift
			stack.unshift a - b
		end
		
		def * stack
			a, b = stack.shift, stack.shift
			stack.unshift a * b
		end
		
		def / stack
			a, b = stack.shift, stack.shift
			stack.unshift a / b
		end
	end
end
