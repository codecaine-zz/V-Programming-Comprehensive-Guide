module main

// Define structs for different shapes
struct Circle {
	radius f64
}

struct Rectangle {
	width  f64
	height f64
}

struct Triangle {
	base   f64
	height f64
}

// Shape is a Sum Type. A Shape variable can store a Circle, Rectangle, or Triangle.
type Shape = Circle | Rectangle | Triangle

// get_area calculates the area depending on the concrete type stored in Shape.
fn get_area(s Shape) f64 {
	// Inside the match branches, the variable is smart-casted to its concrete type.
	match s {
		Circle {
			return 3.14159 * s.radius * s.radius
		}
		Rectangle {
			return s.width * s.height
		}
		Triangle {
			return 0.5 * s.base * s.height
		}
	}
}

fn main() {
	// 1. Creating values of the sum type
	shapes := [
		Shape(Circle{
			radius: 5.0
		}),
		Shape(Rectangle{
			width:  4.0
			height: 6.0
		}),
		Shape(Triangle{
			base:   3.0
			height: 4.0
		}),
	]

	// 2. Iterating and pattern-matching
	for shape in shapes {
		match shape {
			Circle {
				println('Found Circle with radius ${shape.radius}. Area: ${get_area(shape):.2f}')
			}
			Rectangle {
				println('Found Rectangle of ${shape.width}x${shape.height}. Area: ${get_area(shape):.2f}')
			}
			Triangle {
				println('Found Triangle with base ${shape.base} and height ${shape.height}. Area: ${get_area(shape):.2f}')
			}
		}
	}
}
