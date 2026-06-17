pub struct Note {
pub:
	id int
pub mut:
	message string @[required]
	status  bool
}

fn main() {
	_ := Note{
		id:     1
		status: false
	}
}
// throws error