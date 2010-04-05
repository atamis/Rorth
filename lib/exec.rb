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

def forth_exec code
	loc = 0
	while loc < code.length
		if code[loc] == ':'
			word = []
			word_loc = loc
			
			until code[word_loc] == ';'
				word = word.push code[word_loc]
				word_loc += 1
			end
			
			word.shift
			name = word.shift
			$words[name] = word
			loc = word_loc + 1
		end
		if $ENABLE_SEMI_IFs
			if code[loc].downcase == "if"
				if_loc = loc
				if_code = []
				
				until code[if_loc].downcase == "end"
					if_code = if_code.push code[word_loc]
					if_loc += 1
				end
				
				if_code.shift
				puts if_code.join " "
			end
		end
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
		
		if forth_primary? code[loc]
			$stack = $stack.unshift(forth_convert_primary(code[loc]))
		end
		
		if $words.has_key? code[loc]
			forth_exec $words[code[loc]]
		elsif $builtin_words.respond_to? code[loc].downcase.to_sym
			$builtin_words.send code[loc].downcase.to_sym, $stack
		end
		#raise Exception.new "Something went wrong! One of the things you typed in didn\'t get parsed as anything. OH NOES! Word was #{code[loc]}"
		loc += 1
		end

end
