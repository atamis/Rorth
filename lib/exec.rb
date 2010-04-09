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
	
	# Interprets rorth code. Expects an array. Needs some cleaning up.
	#
	# 	code = "2 2 +".split 		# => ['2', '2', '+']
	# 	exec code # => Depends on input
	#
	# An interesting feature/bug is that once a piece of code has been 
	# appraised for one thing, something that doesn't jump around (ifs, 
	# words, and loops,) you could theoretorically have a piece of code
	# do 2 things. For instance, if you had a word called ""word"" (Yes, 
	# that is "word" surrounded by quotations marks) you could push 
	# "word" to the stack and execute a command called "word"
	def exec code
		# Initialize a point to the first item in the list. We don't use code.each because we want the ability to move dynamicaly through the list instead of stepping through it. This becomes very useful when the jump forward through the code with words, ifs, and whiles.
		loc = 0
		
		# While there is still array to work on...
		while loc < code.length
			
			# Check if the code starts a word definition, if it does, initialize another counter, and read the word into another variable.
			if code[loc] == ':'
				word = []
				word_loc = loc
				
				until code[word_loc] == ';'
					word = word.push code[word_loc]
					word_loc += 1
				end
				
				word.shift # Remove the :
				name = word.shift # Remove the name and set it equal to an eponymous variable
				$words[name] = word # Register the word with the words hash/database
				loc = word_loc + 1
			end
			
			# I was messing around with several different types of ifs, and this will enable the ifs system with no "else"
			if $ENABLE_SEMI_IF
				
				# This code is very similar to the word definition code...
				if code[loc].downcase == "if"
					if_loc = loc
					if_code = []
					
					until code[if_loc].downcase == "end"
						if_code = if_code.push code[if_loc]
						if_loc += 1
					end
					
					# Except here, where code is executed if the current stack item is true.
					if_code.shift
					if $stack[0]
						exec if_code
					end
					
					loc = if_loc
				end
			end
			
			# Failed full if section. Not sure why it failed... Maybe we need to regex it to see if it includes an else?
			if $INSERT_IFS
				if code[loc].downcase == "if"
					if_loc = loc
					if_code = []
					else_code = []
					until code[if_loc].downcase == "else" || code[if_loc].downcase == "end"
						if_code.push code[if_loc]
						if_loc += 1
					end
					#if if_code[if_code.length-1].downcase == "else"
					
					#else
					#	if $stack[0]
					#		if_code
					#	end
					#end
					loc = if_loc
				end
			end
			
			# If the code is a primary, convert it, then move it to the front of the stack.
			if primary? code[loc]
				$stack = $stack.unshift(convert_primary(code[loc]))
			end
			
			# Check the various places words are stored to see if any of them match the current code. Note that user and header defined words have precidence over built in words. Theoretoricaly, this means you could really mess with the system if you overrode the "+" word, for instance.
			if $words.has_key? code[loc]
				exec $words[code[loc]]
			elsif $builtin_words.respond_to? code[loc].downcase.to_sym
				$builtin_words.send code[loc].downcase.to_sym, $stack
			end
			#raise Exception.new "Something went wrong! One of the things you typed in didn\'t get parsed as anything. OH NOES! Word was #{code[loc]}"
			
			# Always move forward. This might be moved elsewhere.
			loc += 1
			end
	
	end
end