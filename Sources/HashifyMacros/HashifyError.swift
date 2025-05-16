//
//  HashifyError.swift
//  Hashify
//
//  Created by 茅根啓介 on 2025/05/17.
//

import Foundation

public enum HashifyError: LocalizedError {
    case unsupportedAlgorithms(String)
    case notStringLiteral
    
    public var errorDescription: String? {
        switch self {
        case .unsupportedAlgorithms(let string):
            return "Unsupported algorithms: \(string)"
        case .notStringLiteral:
            return "The first argument must be a string literal"
        }
    }
}

