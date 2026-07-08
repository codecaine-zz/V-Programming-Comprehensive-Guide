# Standard library examples

The standard library examples are grouped by use case so they are easier to browse and easier to connect to real programs. Instead of treating the standard library as a giant list of functions, this section shows common tasks you will actually encounter when building apps.

## Section overview

- [01_text_and_data](01_text_and_data) — string processing, parsing, collections, and serialization for text-heavy programs.
- [02_system_and_files](02_system_and_files) — OS operations, files, archives, compression, and I/O for tools and data processing.
- [03_time_and_utils](03_time_and_utils) — time, benchmarking, math, random values, and small utility modules for everyday logic.
- [04_networking_and_web](04_networking_and_web) — HTTP, sockets, networking, and web-related modules for client/server work.
- [05_cli_and_platform](05_cli_and_platform) — terminal output, command-line parsing, readline, CLI helpers, and runtime/platform topics for command-line apps.
- [06_security_and_runtime](06_security_and_runtime) — logging, crypto, hashing, bitfields, runtime helpers, and WebAssembly for more robust applications.

## Beginner guidance

If you are new to V, focus on the examples that match the kind of program you want to build. A file-related example is useful when you are writing tools, while a networking example is more relevant when you are building a client or web service. The goal is not to memorize every API, but to recognize a few common patterns and know where to look next.

A practical comparison of string building approaches is also available in [01_strings_builder/builder_vs_concat.v](01_strings_builder/builder_vs_concat.v) for readers who want a concrete example of when a builder is preferable to repeated concatenation.
