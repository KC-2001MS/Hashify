//
//  main.swift
//  Hashify
//
//  Created by 茅根啓介 on 2025/05/17.
//

import Hashify

let input = "Example Strings"

// 条件: 同じ入力・同じアルゴリズム、リテラル vs 変数
print("=== Literal vs Variable ===")
print("SHA-256  literal:  \(#hashify("Example Strings", algorithm: .sha256))")
print("SHA-256  variable: \(#hashify(input, algorithm: .sha256))")
print()
print("SHA-512  literal:  \(#hashify("Example Strings", algorithm: .sha512))")
print("SHA-512  variable: \(#hashify(input, algorithm: .sha512))")
print()
print("MD5      literal:  \(#hashify("Example Strings", algorithm: .md5))")
print("MD5      variable: \(#hashify(input, algorithm: .md5))")
print()
print("SHA-1    literal:  \(#hashify("Example Strings", algorithm: .sha1))")
print("SHA-1    variable: \(#hashify(input, algorithm: .sha1))")
print()
print("Default  literal:  \(#hashify("Example Strings"))")
print("Default  variable: \(#hashify(input))")

// 条件: 同じ入力・同じ式の種類、アルゴリズムを変える
print("\n=== Different algorithms, same input ===")
print("SHA-256: \(#hashify(input, algorithm: .sha256))")
print("SHA-512: \(#hashify(input, algorithm: .sha512))")
print("MD5:     \(#hashify(input, algorithm: .md5))")
print("SHA-1:   \(#hashify(input, algorithm: .sha1))")

// 条件: 同じアルゴリズム・同じ式の種類、式のパターンを変える
print("\n=== Different expression patterns (SHA-256) ===")
let name = "World"
func getInput() -> String { "Hello World" }
struct Source { var value: String }
let source = Source(value: "Hello World")

print("literal:       \(#hashify("Hello World"))")
print("variable:      \(#hashify(name))")
print("interpolation: \(#hashify("Hello \(name)"))")
print("concatenation: \(#hashify("Hello" + " " + "World"))")
print("concat+var:    \(#hashify("Hello " + name))")
print("func call:     \(#hashify(getInput()))")
print("property:      \(#hashify(source.value))")
print("method chain:  \(#hashify("hello world".capitalized))")
