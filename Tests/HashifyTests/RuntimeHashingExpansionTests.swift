//
//  RuntimeHashingExpansionTests.swift
//  Hashify
//
//  Created by 茅根啓介 on 2025/05/17.
//

import Testing
import MacroTesting
@testable import HashifyMacros

@Suite("Runtime hashing expansion", .macros(["hashify": HashifyMacro.self]))
struct RuntimeHashingExpansionTests {

    @Test("String interpolation expands to runtime call")
    func stringInterpolation() {
        assertMacro {
            """
            #hashify("hello \\(name)")
            """
        } expansion: {
            """
            HashAlgorithm.sha256.hash("hello \\(name)")
            """
        }
    }

    @Test("Variable reference expands to runtime call")
    func variableReference() {
        assertMacro {
            """
            #hashify(myVar)
            """
        } expansion: {
            """
            HashAlgorithm.sha256.hash(myVar)
            """
        }
    }

    @Test("String concatenation expands to runtime call")
    func stringConcatenation() {
        assertMacro {
            """
            #hashify("test" + "test")
            """
        } expansion: {
            """
            HashAlgorithm.sha256.hash("test" + "test")
            """
        }
    }

    @Test("Function call expands to runtime call")
    func functionCall() {
        assertMacro {
            """
            #hashify(getString())
            """
        } expansion: {
            """
            HashAlgorithm.sha256.hash(getString())
            """
        }
    }

    @Test("Property access expands to runtime call")
    func propertyAccess() {
        assertMacro {
            """
            #hashify(obj.property)
            """
        } expansion: {
            """
            HashAlgorithm.sha256.hash(obj.property)
            """
        }
    }

    @Test("Method chain expands to runtime call")
    func methodChain() {
        assertMacro {
            """
            #hashify(input.lowercased())
            """
        } expansion: {
            """
            HashAlgorithm.sha256.hash(input.lowercased())
            """
        }
    }

    @Test("Runtime call with explicit algorithm")
    func runtimeWithExplicitAlgorithm() {
        assertMacro {
            """
            #hashify(myVar, algorithm: .sha512)
            """
        } expansion: {
            """
            HashAlgorithm.sha512.hash(myVar)
            """
        }
    }

    @Test("Mixed string and variable concatenation expands to runtime call")
    func mixedConcatenation() {
        assertMacro {
            """
            #hashify("test" + myVar)
            """
        } expansion: {
            """
            HashAlgorithm.sha256.hash("test" + myVar)
            """
        }
    }

    // MARK: - Custom algorithm expansion

    @Test("Custom algorithm with string literal expands to runtime call")
    func customAlgorithmStringLiteral() {
        assertMacro {
            """
            #hashify("test", algorithm: .customAlgo)
            """
        } expansion: {
            """
            HashAlgorithm.customalgo.hash("test")
            """
        }
    }

    @Test("Custom algorithm with variable expands to runtime call")
    func customAlgorithmVariable() {
        assertMacro {
            """
            #hashify(myVar, algorithm: .customAlgo)
            """
        } expansion: {
            """
            HashAlgorithm.customalgo.hash(myVar)
            """
        }
    }
}
