//
//  Hashify.swift
//  Hashify
//
//  Created by 茅根啓介 on 2025/05/17.
//
// The Swift Programming Language
// https://docs.swift.org/swift-book

/// A macro that generates a hash value for a given string by specifying a string and a hash value algorithm.
/// For example,
///
/// #hashify(“Example Strings”, algorithm: .sha512)
///
/// generates the string `"00e21cd306b86c0d806393e49d2da9f22794392d700898975099ca029ac4c2d4a5eae23519b20f65d9c9471c9074337662a2bd87640a6c42cea07fca 1743b585"`.
@freestanding(expression)
public macro hashify(_ value: String, algorithm: HashAlgorithm = .sha256) -> String = #externalMacro(module: "HashifyMacros", type: "HashifyMacro")
