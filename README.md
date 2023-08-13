# MFRBaseArchitecture

**MFRBaseArchitecture** is simple an implementation of several architectures for using iOS platform.

This project aims to make some architecures usage and adoption easier, facilitating all needed settings for working with this architecture and trying to reduce as much as possible the manual work arised due to its characteristic.

**MFRBaseArchitecture** provide easier use for:
- **VIPER Architecure**, [see the docs](https://github.com/marcofebriano/MFRBaseArchitecture/blob/main/VIPER.md)
- **MVVM+Router Architecture**
- **MVP+Router Architecture**

## INSTALATION
```swift
dependencies: [
    .package(url: "https://github.com/marcofebriano/MFRBaseArchitecture.git", .upToNextMajor(from: "1.0.0"))
]
```

Use it in your target as `MFRBaseArchitecture`

```swift
 .target(
    name: "yourModule",
    dependencies: ["MFRBaseArchitecture"]
)
```