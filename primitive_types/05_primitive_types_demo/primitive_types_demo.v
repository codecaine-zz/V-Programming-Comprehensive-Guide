module main

fn main() {
	println('==================================================')
	println('        Vlang Primitive Data Types Demo           ')
	println('==================================================')

	// 1. Boolean Type
	b := true
	println('Boolean: val: ${b} | type: ${typeof(b).name} | size: ${sizeof(b)} byte')

	// 2. String Type
	s := 'Hello, V!'
	println('String:  val: "${s}" | type: ${typeof(s).name} | size: ${sizeof(s)} bytes')

	// 3. Rune Type (unicode character, represented as `r` prefix or backticks)
	r := `V`
	println('Rune:    val: ${r} (char: ${r.str()}) | type: ${typeof(r).name} | size: ${sizeof(r)} bytes')

	// 4. Signed Integers
	i_8 := i8(-128)
	i_16 := i16(-32768)
	i_32 := int(-2147483648)
	i_64 := i64(-9223372036854775808)
	println('i8:      val: ${i_8} | type: ${typeof(i_8).name} | size: ${sizeof(i_8)} byte')
	println('i16:     val: ${i_16} | type: ${typeof(i_16).name} | size: ${sizeof(i_16)} bytes')
	println('int:     val: ${i_32} | type: ${typeof(i_32).name} | size: ${sizeof(i_32)} bytes')
	println('i64:     val: ${i_64} | type: ${typeof(i_64).name} | size: ${sizeof(i_64)} bytes')

	// 5. Unsigned Integers
	u_8 := u8(255)
	u_16 := u16(65535)
	u_32 := u32(4294967295)
	u_64 := u64(18446744073709551615)
	println('u8:      val: ${u_8} | type: ${typeof(u_8).name} | size: ${sizeof(u_8)} byte')
	println('u16:     val: ${u_16} | type: ${typeof(u_16).name} | size: ${sizeof(u_16)} bytes')
	println('u32:     val: ${u_32} | type: ${typeof(u_32).name} | size: ${sizeof(u_32)} bytes')
	println('u64:     val: ${u_64} | type: ${typeof(u_64).name} | size: ${sizeof(u_64)} bytes')

	// 6. Platform-dependent Sizes
	isize_val := isize(-12345)
	usize_val := usize(12345)
	println('isize:   val: ${isize_val} | type: ${typeof(isize_val).name} | size: ${sizeof(isize_val)} bytes')
	println('usize:   val: ${usize_val} | type: ${typeof(usize_val).name} | size: ${sizeof(usize_val)} bytes')

	// 7. Floating Point Numbers
	f_32 := f32(3.14159)
	f_64 := f64(2.718281828459)
	println('f32:     val: ${f_32} | type: ${typeof(f_32).name} | size: ${sizeof(f_32)} bytes')
	println('f64:     val: ${f_64} | type: ${typeof(f_64).name} | size: ${sizeof(f_64)} bytes')

	println('==================================================')
}
