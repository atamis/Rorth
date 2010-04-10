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

$:.unshift File.join(File.dirname(__FILE__),'..','lib') # To make sure the requires work out

require "test/unit"

require "primary"


class TestPrimary < Test::Unit::TestCase
	include Rorth
	
	def test_identify
		["145", "\"test\"", "\"word\"", "true", "false"].each do |x|
			assert(primary?(x), "Something was not a primary. Thing was #{x}")
		end
		
		["test", 533, "awesome", "flase"].each do |x|
			assert(!primary?(x), "Oops, something was a primary. Was #{x}")
		end
	end
	
	def test_convert
		{"423" => 423, "true" => true, "false" => false, "\"something\"" => "something"}.each do |k, i|
			assert_equal(convert_primary(k), i, "Error was in #{k} => #{i}")
		end
	end
end
	