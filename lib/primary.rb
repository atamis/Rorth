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
