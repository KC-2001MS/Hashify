# Hashify
Hashify is a Swift macro framework that provides a compile-time hashing feature for string literals.  
It helps you hide meaningful strings like keys or identifiers from your binary by replacing them with their hashed versions during compilation.

## Features and Futures
I would like the framework to have the following features
- [x] Compile-time hashing of string literals
- [x] Support for multiple algorithms: SHA256, SHA512, MD5, SHA1

## Usage
To hash a string literal at compile time, use the `#hashify(_:algorithm:)` macro:
```swift
import Hashify

let sha512Result = #hashify("Example Strings", algorithm: .sha512)

print("Example Strings -- SHA-512 -> \(sha512Result)")
```

The output results are as follows
```plaintext
Example Strings -- SHA-512 -> 00e21cd306b86c0d806393e49d2da9f22794392d700898975099ca029ac4c2d4a5eae23519b20f65d9c9471c9074337662a2bd87640a6c42cea07fca 1743b585
```
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
