module main

import strings.lorem

fn main() {
	println('=== V strings.lorem Standard Library Demo ===')

	// 1. Basic Generation with Default Configuration
	// By default, it will choose a random corpus, seed phrase, and RNG seed.
	println('\n--- 1. Default Lorem Ipsum Generation ---')
	default_lorem := lorem.generate(lorem.LoremCfg{})
	println(default_lorem)

	// 2. Custom Layout Configuration (Paragraphs, Sentences, Words)
	println('\n--- 2. Custom Layout Generation ---')
	custom_layout := lorem.generate(lorem.LoremCfg{
		paragraphs: 2
		sentences_per_paragraph: 3
		words_per_sentence: 6
	})
	println(custom_layout)

	// 3. Selection of Specific Embedded Corpora
	// V's strings.lorem module supports four built-in corpora:
	// - 'lorem' (Standard Latin Lorem Ipsum)
	// - 'poe' (Edgar Allan Poe's The Raven)
	// - 'darwin' (Charles Darwin's Origin of Species)
	// - 'bard' (William Shakespeare's works)
	println('\n--- 3. Specific Corpora Examples ---')
	
	corpora := ['lorem', 'poe', 'darwin', 'bard']
	for corpus in corpora {
		text := lorem.generate(lorem.LoremCfg{
			corpus_name: corpus
			paragraphs: 1
			sentences_per_paragraph: 2
			words_per_sentence: 8
		})
		println('Corpus [${corpus}]:')
		println(text)
		println('-'.repeat(40))
	}

	// 4. Deterministic Text Generation using RNG Seed and Custom Seed Phrases
	// Using a specific `rng_seed` guarantees that the generated pseudo-random text is deterministic
	// and identical across multiple runs. Custom `seed_text` provides a starting phrase for the Markov chain.
	println('\n--- 4. Deterministic Generation with Seed & Custom Starting Phrase ---')
	deterministic_lorem_1 := lorem.generate(lorem.LoremCfg{
		corpus_name: 'poe'
		rng_seed: 42
		seed_text: 'once upon a midnight'
		paragraphs: 1
		sentences_per_paragraph: 2
		words_per_sentence: 8
	})
	
	deterministic_lorem_2 := lorem.generate(lorem.LoremCfg{
		corpus_name: 'poe'
		rng_seed: 42
		seed_text: 'once upon a midnight'
		paragraphs: 1
		sentences_per_paragraph: 2
		words_per_sentence: 8
	})

	println('Run 1:')
	println(deterministic_lorem_1)
	println('\nRun 2:')
	println(deterministic_lorem_2)

	// Assert that they are exactly identical due to deterministic seeding
	assert deterministic_lorem_1 == deterministic_lorem_2
	println('\nDeterministic assertion passed! Both runs generated identical text.')
}
