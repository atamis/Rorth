
def forth_init
	$stack = []
	$words = {}
	$builtin_words = BuiltinWords.new
end