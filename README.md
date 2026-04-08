# Hashify
Hashify is a Swift macro framework that provides hashing features for strings.  
When a string literal without interpolation is passed, the macro replaces it with the hashed value at compile time. Since the macro expands the literal directly into its hash, the original string is completely removed from the source code and does not appear in the compiled binary. This allows you to hide meaningful strings such as keys and identifiers from reverse engineering.  
For variables and other expressions, the hash is computed at runtime.

## Features and Futures
I would like the framework to have the following features
- [x] Compile-time hashing of string literals without interpolation
- [x] Runtime hashing of variables and expressions
- [x] Support for multiple algorithms: SHA256, SHA384, SHA512, MD5, SHA1
- [x] Extensible `HashAlgorithm` — add your own algorithms via extensions

## Usage

### Compile-time hashing (string literals without interpolation)
When you pass a string literal that does not contain interpolation, the macro computes the hash at compile time and replaces the literal entirely with the hash value. The original string does not remain in the compiled binary:
```swift
import Hashify

let sha512Result = #hashify("Example Strings", algorithm: .sha512)

print("Example Strings -- SHA-512 -> \(sha512Result)")
```

The output results are as follows
```plaintext
Example Strings -- SHA-512 -> 00e21cd306b86c0d806393e49d2da9f22794392d700898975099ca029ac4c2d4a5eae23519b20f65d9c9471c9074337662a2bd87640a6c42cea07fca1743b585
```

### Runtime hashing (variables and expressions)
When you pass a variable, string interpolation, concatenation, or any other expression, the hash is computed at runtime:
```swift
import Hashify

let input = "Example Strings"

// Variable
let result1 = #hashify(input, algorithm: .sha256)

// String interpolation
let name = "World"
let result2 = #hashify("Hello \(name)")

// Concatenation
let result3 = #hashify("Hello" + " " + "World")

// Function call
let result4 = #hashify(getInput())
```

### Custom algorithms
`HashAlgorithm` is an extensible struct. You can add your own algorithm by providing a `HashFunction`-conforming type from CryptoKit:
```swift
import CryptoKit
import Hashify

extension HashAlgorithm {
    static let sha3_256 = HashAlgorithm(rawValue: "sha3_256", hashFunction: SHA3Digest256.self)
}

let result = #hashify("secret", algorithm: .sha3_256)
```

For algorithms that don't conform to `HashFunction`, use the closure-based initializer:
```swift
extension HashAlgorithm {
    static let crc32 = HashAlgorithm(rawValue: "crc32") { data in
        // Your custom implementation returning a hex string
    }
}
```

Custom algorithms are always expanded to a runtime function call. Compile-time hashing is available for the built-in algorithms (MD5, SHA-1, SHA-256, SHA-384, SHA-512).

All algorithms are automatically registered and can be looked up by name via `HashAlgorithm(rawValue:)` at runtime.

## Installation
You can add it to your project using the Swift Package Manager To add Hashify to your Xcode project, select File > Add Package Dependancies... and find the repository URL:  
`https://github.com/KC-2001MS/Hashify.git`.

## Contributions
See [CONTRIBUTING.md](https://github.com/KC-2001MS/Hashify/blob/main/CONTRIBUTING.md) if you want to make a contribution.

## Documents
Documentation on the Hashify framework can be found [here](https://iroiro.dev/Hashify/documentation/hashify/).

## License
This library is released under Apache-2.0 license. See [LICENSE](https://github.com/KC-2001MS/Hashify/blob/main/LICENSE) for details.

## Supporting
If you would like to make a donation to this project, please click here. The money you give will be used to improve my programming skills and maintain the application.  
<a href="https://www.buymeacoffee.com/iroiro" target="_blank">
    <img src="https://cdn.buymeacoffee.com/buttons/v2/default-yellow.png" alt="Buy Me A Coffee" style="height: 60px !important;width: 217px !important;" >
</a>  
[Pay by PayPal](https://paypal.me/iroiroWork?country.x=JP&locale.x=ja_JP)

## Author
[Keisuke Chinone](https://github.com/KC-2001MS)
