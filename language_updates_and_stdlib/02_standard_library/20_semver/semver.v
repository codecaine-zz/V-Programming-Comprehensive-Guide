module main

import semver

fn main() {
	println('=== semver Module Demo ===')

	// 1. Parsing semver strings
	v1 := semver.from('1.5.0-beta.1+build.123') or {
		println('Failed to parse version: ${err}')
		return
	}
	v2 := semver.from('1.5.0') or {
		println('Failed to parse version: ${err}')
		return
	}
	v3 := semver.from('2.0.0-rc.1') or {
		println('Failed to parse version: ${err}')
		return
	}

	// 2. Accessing parts of the version struct
	println('Version 1 components:')
	println('  Raw string: ${v1.str()}')
	println('  Major:      ${v1.major}')
	println('  Minor:      ${v1.minor}')
	println('  Patch:      ${v1.patch}')
	println('  Prerelease: ${v1.prerelease}')
	println('  Build info: ${v1.metadata}')

	// 3. Comparisons using relational operators
	println('\nVersion Comparisons:')
	println('  ${v1} < ${v2} ? -> ${v1 < v2}')
	println('  ${v2} > ${v1} ? -> ${v2 > v1}')
	println('  ${v3} >= ${v2} ? -> ${v3 >= v2}')

	// 4. Checking against version ranges (constraints)
	println('\nVersion Constraint Satisfactions:')
	// Range checking
	println('  Is ${v2} in range ">=1.0.0 <2.0.0" ? -> ${v2.satisfies('>=1.0.0 <2.0.0')}')
	println('  Is ${v3} in range ">=1.0.0 <2.0.0" ? -> ${v3.satisfies('>=1.0.0 <2.0.0')}')

	// Complex constraint checking using logical OR (||)
	range_query := '^1.4.0 || >=2.0.0'
	println('  Does ${v2} satisfy "${range_query}"? -> ${v2.satisfies(range_query)}')
	println('  Does ${v3} satisfy "${range_query}"? -> ${v3.satisfies(range_query)}')
}
