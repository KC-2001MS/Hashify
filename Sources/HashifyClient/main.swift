//
//  main.swift
//  Hashify
//
//  Created by 茅根啓介 on 2025/05/17.
//

import Hashify

let sha512Result = #hashify("Example Strings", algorithm: .sha512)

print("Example Strings -- SHA-512 -> \(sha512Result)")


let sha256Result1 = #hashify("Example Strings", algorithm: .sha256)

print("Example Strings -- SHA-256 -> \(sha256Result1)")

let sha256Result2 = #hashify("Example Strings")

print("Example Strings -- SHA-256 -> \(sha256Result2)")
