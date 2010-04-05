
module Rorth
	def init
		$stack = []
		$words = {}
		$builtin_words = BuiltinWords.new
	end
end