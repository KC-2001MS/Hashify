//
//  HashAlgorithm.swift
//  Hashify
//
//  Created by 茅根啓介 on 2025/05/17.
//

/// Indicates the algorithm type of the hash value
public enum HashAlgorithm: String, Codable {
    case md5
    case sha1
    case sha256
    case sha512
}
