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
	
	# Enable the full if code, which is broken.
	$INSERT_IFS = false
	
	# Enable the semi if code, which does work.
	$ENABLE_SEMI_IF = true
	
	# Initialize a veriaty of global variables that the rorth system relies on.
	class Interpreter
		attr_accessor :stack, :words, :builtin_words, :tmp, :options
		def initialize(options)
			@stack = []
			@words = {}
			@builtin_words = BuiltinWords.new
			@tmp = nil
			@options = options
	end
	end
end
