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
#				This file is just a stub really

module Rorth
	# Enter the interactive system, like irb. A readline version of it has been 
	# partialy implemented. No history, and no support for input methods other 
	# than readline.
	def enter_interactive
		begin
			require 'readline'
		rescue LoadError
			puts "Could not load readline."
		end
		
		if $options[:restore_tty_interactive]
			stty_save = `stty -g`.chomp
			trap('INT') { system('stty', stty_save); exit }
		end
		
		while line = Readline.readline('> ', true)
			begin
				interactive_exec line.to_s.split(' ')
			rescue CodeNotUsed => e
				puts "CodeNotUsed error: " + e
			end
		end
		
		#puts "Entering interactive mode... wait, there isn't an interactive mode yet? Well, it's on the TODO list!"
		exit
	end
	
	private
	def interactive_exec ary # :nodoc:
		case ary[0]
			when /stack/
				puts $stack.inspect
			else
				exec ary
		end
	end
end
