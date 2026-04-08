//
//  HashAlgorithmTests.swift
//  Hashify
//
//  Created by 茅根啓介 on 2025/05/17.
//

import Testing
import Hashify
import CryptoKit

extension HashAlgorithm {
    fileprivate static let customSha256 = HashAlgorithm(
        rawValue: "customsha256", hashFunction: SHA256.self
    )
    fileprivate static let closureBased = HashAlgorithm(
        rawValue: "closurebased"
    ) { data in
        SHA256.hash(data: data).map { String(format: "%02x", $0) }.joined()
    }
}

@Suite("HashAlgorithm.hash(_:)")
struct HashAlgorithmTests {

    @Test("SHA-256 produces correct hash")
    func sha256() {
        let result = HashAlgorithm.sha256.hash("test")
        #expect(result == "9f86d081884c7d659a2feaa0c55ad015a3bf4f1b2b0b822cd15d6c15b0f00a08")
    }

    @Test("SHA-512 produces correct hash")
    func sha512() {
        let result = HashAlgorithm.sha512.hash("test")
        #expect(result == "ee26b0dd4af7e749aa1a8ee3c10ae9923f618980772e473f8819a5d4940e0db27ac185f8a0e1d5f84f88bc887fd67b143732c304cc5fa9ad8e6f57f50028a8ff")
    }

    @Test("MD5 produces correct hash")
    func md5() {
        let result = HashAlgorithm.md5.hash("test")
        #expect(result == "098f6bcd4621d373cade4e832627b4f6")
    }

    @Test("SHA-1 produces correct hash")
    func sha1() {
        let result = HashAlgorithm.sha1.hash("test")
        #expect(result == "a94a8fe5ccb19ba61c4c0873d391e987982fbbd3")
    }

    @Test("SHA-384 produces correct hash")
    func sha384() {
        let result = HashAlgorithm.sha384.hash("test")
        #expect(result == "768412320f7b0aa5812fce428dc4706b3cae50e02a64caa16a782249bfe8efc4b7ef1ccb126255d196047dfedf17a0a9")
    }

    @Test("Empty string hashing")
    func emptyString() {
        let result = HashAlgorithm.sha256.hash("")
        #expect(result == "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855")
    }

    // MARK: - Custom algorithm runtime hashing

    @Test("Custom HashFunction-based algorithm produces correct hash")
    func customHashFunction() {
        let result = HashAlgorithm.customSha256.hash("test")
        #expect(result == "9f86d081884c7d659a2feaa0c55ad015a3bf4f1b2b0b822cd15d6c15b0f00a08")
    }

    @Test("Custom closure-based algorithm produces correct hash")
    func customClosure() {
        let result = HashAlgorithm.closureBased.hash("test")
        #expect(result == "9f86d081884c7d659a2feaa0c55ad015a3bf4f1b2b0b822cd15d6c15b0f00a08")
    }
}
