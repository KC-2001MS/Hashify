//
//  HashAlgorithm.swift
//  Hashify
//
//  Created by 茅根啓介 on 2025/05/17.
//

import CryptoKit
import Foundation

/// Indicates the algorithm type of the hash value.
///
/// Hashify ships with built-in algorithms (`.md5`, `.sha1`, `.sha256`,
/// `.sha384`, `.sha512`).  You can add your own using any
/// `HashFunction`-conforming type from CryptoKit:
///
/// ```swift
/// extension HashAlgorithm {
///     static let sha3_256 = HashAlgorithm(rawValue: "sha3_256", hashFunction: SHA3Digest256.self)
/// }
/// ```
public struct HashAlgorithm: Hashable, Sendable {

    /// The string identifier of the algorithm (e.g. `"sha256"`).
    public let rawValue: String

    private let _hasher: @Sendable (Data) -> String

    // MARK: - Registry

    private static let _lock = NSLock()
    nonisolated(unsafe) private static var _registry: [String: HashAlgorithm] = [:]

    private static func _register(_ algorithm: HashAlgorithm) {
        _lock.lock()
        defer { _lock.unlock() }
        _registry[algorithm.rawValue] = algorithm
    }

    private static func _lookup(_ rawValue: String) -> HashAlgorithm? {
        _lock.lock()
        defer { _lock.unlock() }
        return _registry[rawValue]
    }

    // MARK: - Initializers

    /// Creates a hash algorithm backed by a `HashFunction` type from CryptoKit.
    ///
    /// Algorithms created with this initializer are automatically registered
    /// and can be looked up by ``init(rawValue:)`` at runtime.
    ///
    /// - Parameters:
    ///   - rawValue: A unique string identifier for the algorithm.
    ///   - hashFunction: A `HashFunction`-conforming type (e.g. `SHA384.self`).
    public init<H: HashFunction>(rawValue: String, hashFunction: H.Type) {
        self.rawValue = rawValue
        self._hasher = { data in
            H.hash(data: data)
                .map { String(format: "%02x", $0) }
                .joined()
        }
        Self._register(self)
    }

    /// Creates a hash algorithm with a custom hashing closure.
    ///
    /// Use this initializer for algorithms that don't conform to `HashFunction`.
    /// Algorithms created with this initializer are automatically registered
    /// and can be looked up by ``init(rawValue:)`` at runtime.
    ///
    /// - Parameters:
    ///   - rawValue: A unique string identifier for the algorithm.
    ///   - hasher: A closure that takes `Data` and returns the hex-encoded hash string.
    public init(rawValue: String, hasher: @escaping @Sendable (Data) -> String) {
        self.rawValue = rawValue
        self._hasher = hasher
        Self._register(self)
    }

    /// Looks up an algorithm by its raw value.
    ///
    /// This first checks the runtime registry for user-registered algorithms,
    /// then falls back to the known CryptoKit `HashFunction` types so that the
    /// macro plugin can compute hashes at compile time without prior registration.
    ///
    /// Returns `nil` if `rawValue` does not match any known or registered algorithm.
    public init?(rawValue: String) {
        if let algo = Self._lookup(rawValue) {
            self = algo
            return
        }
        switch rawValue {
        case "md5":    self.init(rawValue: rawValue, hashFunction: Insecure.MD5.self)
        case "sha1":   self.init(rawValue: rawValue, hashFunction: Insecure.SHA1.self)
        case "sha256": self.init(rawValue: rawValue, hashFunction: SHA256.self)
        case "sha384": self.init(rawValue: rawValue, hashFunction: SHA384.self)
        case "sha512": self.init(rawValue: rawValue, hashFunction: SHA512.self)
        default:       return nil
        }
    }

    // MARK: - Hashing

    /// Computes the hex-encoded hash of the given string.
    public func hash(_ value: String) -> String {
        _hasher(Data(value.utf8))
    }

    /// Computes the hex-encoded hash of the given data.
    public func hash(data: Data) -> String {
        _hasher(data)
    }

    // MARK: - Hashable

    public static func == (lhs: HashAlgorithm, rhs: HashAlgorithm) -> Bool {
        lhs.rawValue == rhs.rawValue
    }

    public func hash(into hasher: inout Hasher) {
        hasher.combine(rawValue)
    }

    // MARK: - Built-in Algorithms

    public static let md5 = HashAlgorithm(rawValue: "md5", hashFunction: Insecure.MD5.self)
    public static let sha1 = HashAlgorithm(rawValue: "sha1", hashFunction: Insecure.SHA1.self)
    public static let sha256 = HashAlgorithm(rawValue: "sha256", hashFunction: SHA256.self)
    public static let sha384 = HashAlgorithm(rawValue: "sha384", hashFunction: SHA384.self)
    public static let sha512 = HashAlgorithm(rawValue: "sha512", hashFunction: SHA512.self)
}
