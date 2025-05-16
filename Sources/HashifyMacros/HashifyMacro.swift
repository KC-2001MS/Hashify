//
//  HashifyMacro.swift
//  Hashify
//
//  Created by 茅根啓介 on 2025/05/17.
//

import SwiftCompilerPlugin
import SwiftSyntax
import SwiftSyntaxBuilder
import SwiftSyntaxMacros
import CryptoKit
import Foundation

/// Implementation of the `hashify` macro, which takes a string literal and a type of hashing algorithm and generates a hash value.
/// For example
///
///  #hashify(“Example Strings”, algorithm: .sha512)
///
///  will expand to
///
/// "00e21cd306b86c0d806393e49d2da9f22794392d700898975099ca029ac4c2d4a5eae23519b20f65d9c9471c9074337662a2bd87640a6c42cea07fca 1743b585"
public struct HashifyMacro: ExpressionMacro {
    public static func expansion(
        of node: some FreestandingMacroExpansionSyntax,
        in context: some MacroExpansionContext
    ) throws -> ExprSyntax {
        let args = node.arguments

        guard let stringArg = args.first(where: { $0.label == nil })?.expression.as(
            StringLiteralExprSyntax.self
        ),
              let segment = stringArg.segments.first?.as(
                StringSegmentSyntax.self
              )
        else {
            throw HashifyError.notStringLiteral
        }
        let input = segment.content.text

        let algorithm: String
        if let algoArg = args.first(where: { $0.label?.text == "algorithm" })?.expression.as(
            MemberAccessExprSyntax.self
        ) {
            algorithm = algoArg.declName.baseName.text.lowercased()
        } else {
            algorithm = "sha256"
        }

        let hashed = try hashString(input, algorithm: algorithm)
        return "\"\(raw: hashed)\""
    }

    private static func hashString(_ input: String, algorithm: String) throws -> String {
        let data = Data(input.utf8)
        switch algorithm {
        case "sha256":
            return SHA256
                .hash(data: data)
                .map { String(format: "%02x", $0) }
                .joined()
        case "sha512":
            return SHA512
                .hash(data: data)
                .map { String(format: "%02x", $0) }
                .joined()
        case "md5":
            return Insecure.MD5
                .hash(data: data)
                .map { String(format: "%02x", $0) }
                .joined()
        case "sha1":
            return Insecure.SHA1
                .hash(data: data)
                .map { String(format: "%02x", $0) }
                .joined()
        default:
            throw HashifyError.unsupportedAlgorithms(algorithm)
        }
    }
}

@main
struct HashifyPlugin: CompilerPlugin {
    let providingMacros: [Macro.Type] = [
        HashifyMacro.self,
    ]
}
