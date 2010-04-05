
$INSERT_IFS = false
$ENABLE_SEMI_IF = true

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

class WordNotFound < NameError
end

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

def forth_primary? x
	if x =~ /".*"/ || x =~ /[1234567890]+/
		true
	elsif !x.is_a?(Integer)
		x.downcase == "true" || x.downcase == "false"
	else
		false
	end
end

def forth_convert_primary x
	if x =~/"(.*)"/
		x = x.split(//)
		x.shift
		x.pop
		x.join('')
	elsif x =~ /[1234567890]+/ 
		x.to_i
	elsif x.downcase == "true"
		true
	elsif x.downcase == "false"
		false
	end
end


$stack = []

code = <<END
"test" 5 123 +
END

header = <<END
: FIB tmpg dup tmpp + ;
: awesome + 5 - ;
END

code = ARGV[0] if ARGV[0]

$words = {}
$builtin_words = BuiltinWords.new
code = code.split(" ")

$tmp = nil


forth_exec code

puts $stack.inspect if $DEBUG
