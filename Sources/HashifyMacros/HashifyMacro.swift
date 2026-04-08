//
//  HashifyMacro.swift
//  Hashify
//
//  Created by 茅根啓介 on 2025/05/17.
//

import SwiftCompilerPlugin
import SwiftSyntax
import SwiftSyntaxMacros
import HashifyCore

/// Implementation of the `hashify` macro, which takes a string literal and a type of hashing algorithm and generates a hash value.
/// For example
///
///  #hashify(“Example Strings”, algorithm: .sha512)
///
///  will expand to
///
/// "00e21cd306b86c0d806393e49d2da9f22794392d700898975099ca029ac4c2d4a5eae23519b20f65d9c9471c9074337662a2bd87640a6c42cea07fca 1743b585"
public struct HashifyMacro: ExpressionMacro {

    /// Built-in algorithms eligible for compile-time hashing.
    /// User-defined extensions always expand to a runtime function call.
    private static let builtInAlgorithms: Set<String> = [
        "md5", "sha1", "sha256", "sha384", "sha512",
    ]

    public static func expansion(
        of node: some FreestandingMacroExpansionSyntax,
        in context: some MacroExpansionContext
    ) throws -> ExprSyntax {
        let args = node.arguments

        guard let valueArg = args.first(where: { $0.label == nil }) else {
            throw HashifyError.notStringLiteral
        }
        let valueExpr = valueArg.expression

        // Determine the algorithm
        let algorithmString: String
        if let algoArg = args.first(where: { $0.label?.text == "algorithm" })?.expression.as(
            MemberAccessExprSyntax.self
        ) {
            algorithmString = algoArg.declName.baseName.text.lowercased()
        } else {
            algorithmString = "sha256"
        }

        // Compile-time hashing: only for built-in algorithms with pure string literals
        if builtInAlgorithms.contains(algorithmString),
           let stringLiteral = valueExpr.as(StringLiteralExprSyntax.self),
           stringLiteral.segments.allSatisfy({ $0.is(StringSegmentSyntax.self) }),
           let algorithm = HashAlgorithm(rawValue: algorithmString) {
            let input = stringLiteral.segments
                .compactMap { $0.as(StringSegmentSyntax.self)?.content.text }
                .joined()
            let hashed = algorithm.hash(input)
            return "\"\(raw: hashed)\""
        }

        // Runtime hashing: generate a direct call to HashAlgorithm.hash(_:)
        return "HashAlgorithm.\(raw: algorithmString).hash(\(valueExpr))"
    }

}

@main
struct HashifyPlugin: CompilerPlugin {
    let providingMacros: [Macro.Type] = [
        HashifyMacro.self,
    ]
}
