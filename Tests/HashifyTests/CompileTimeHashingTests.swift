//
//  CompileTimeHashingTests.swift
//  Hashify
//
//  Created by 茅根啓介 on 2025/05/17.
//

import Testing
import MacroTesting
@testable import HashifyMacros

@Suite("Compile-time hashing", .macros(["hashify": HashifyMacro.self]))
struct CompileTimeHashingTests {

    @Test("Pure string literal with SHA-256 (default)")
    func pureStringLiteralDefaultAlgorithm() {
        assertMacro {
            """
            #hashify("test")
            """
        } expansion: {
            """
            "9f86d081884c7d659a2feaa0c55ad015a3bf4f1b2b0b822cd15d6c15b0f00a08"
            """
        }
    }

    @Test("Pure string literal with SHA-512")
    func pureStringLiteralSHA512() {
        assertMacro {
            """
            #hashify("test", algorithm: .sha512)
            """
        } expansion: {
            """
            "ee26b0dd4af7e749aa1a8ee3c10ae9923f618980772e473f8819a5d4940e0db27ac185f8a0e1d5f84f88bc887fd67b143732c304cc5fa9ad8e6f57f50028a8ff"
            """
        }
    }

    @Test("Pure string literal with MD5")
    func pureStringLiteralMD5() {
        assertMacro {
            """
            #hashify("test", algorithm: .md5)
            """
        } expansion: {
            """
            "098f6bcd4621d373cade4e832627b4f6"
            """
        }
    }

    @Test("Pure string literal with SHA-1")
    func pureStringLiteralSHA1() {
        assertMacro {
            """
            #hashify("test", algorithm: .sha1)
            """
        } expansion: {
            """
            "a94a8fe5ccb19ba61c4c0873d391e987982fbbd3"
            """
        }
    }

    @Test("Pure string literal with SHA-384")
    func pureStringLiteralSHA384() {
        assertMacro {
            """
            #hashify("test", algorithm: .sha384)
            """
        } expansion: {
            """
            "768412320f7b0aa5812fce428dc4706b3cae50e02a64caa16a782249bfe8efc4b7ef1ccb126255d196047dfedf17a0a9"
            """
        }
    }

    @Test("Empty string literal")
    func emptyStringLiteral() {
        assertMacro {
            """
            #hashify("")
            """
        } expansion: {
            """
            "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855"
            """
        }
    }
}
