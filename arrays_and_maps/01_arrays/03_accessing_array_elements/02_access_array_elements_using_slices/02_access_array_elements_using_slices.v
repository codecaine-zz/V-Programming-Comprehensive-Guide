fn main() {
	mut sports := ['cricket', 'hockey', 'football', 'basketball', 'tennis']
	
	// Positive slicing: from index 1 to 3 (excluding index 3)
	println(sports[1..3]) // ['hockey', 'football']
	
	// V does not support negative indices natively in slices (e.g., sports[-2..] will not compile).
	// To achieve "negative slicing" (indexing from the end of the array), use the `.len` property:
	
	// Slice up to the last element (excluding it): Python's sports[..-1]
	println(sports[..sports.len - 1]) // ['cricket', 'hockey', 'football', 'basketball']
	
	// Slice from 3rd to last up to 1st to last (excluding it): Python's sports[-3..-1]
	println(sports[sports.len - 3..sports.len - 1]) // ['football', 'basketball']
	
	// Slice the last two elements: Python's sports[-2..]
	println(sports[sports.len - 2..]) // ['basketball', 'tennis']
}
