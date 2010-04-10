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

	# Check to see if a given string could be converted into a forth primary.
	def primary? x
		if x =~ /".*"/ || x =~ /[1234567890]+/
			true
		elsif !x.is_a?(Integer) 
			x.downcase == "true" || x.downcase == "false"
		else
			false
		end
	end
	
	# Convert a string to a forth primary. Presumably, use this after using primary?, so things don't get mixed up.
	def convert_primary x
		if x =~/"(.*)"/
			x = x.split(//) # There must be a better way to strip the "s of the string. See the TODO file.
			x.shift
			x.pop
			x.join('')
		elsif x =~ /[1234567890]+/ # Check to see if it's a number. There is probably way of doing this.
			x.to_i
		elsif x.downcase == "true" # Convert string to actual.
			true
		elsif x.downcase == "false"
			false
		end
	end
end

