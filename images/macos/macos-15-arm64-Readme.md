| Announcements |
|-|
| [[macOS] Xcode support policy will be changed on August 11, 2025](https://github.com/actions/runner-images/issues/12541) |
| [[macOS] macos-latest YAML-label will use macos-15 in August 2025](https://github.com/actions/runner-images/issues/12520) |
***
# macOS 15
- OS Version: macOS 15.5 (24F74)
- Kernel Version: Darwin 24.5.0
- Image Version: 20250714.1971

## Installed Software

### Language and Runtime
- .NET Core SDK: 8.0.101, 8.0.204, 8.0.303, 8.0.412, 9.0.102, 9.0.203, 9.0.302
- Bash 3.2.57(1)-release
- Clang/LLVM 16.0.0
- Clang/LLVM (Homebrew) 18.1.8 - available on `$(brew --prefix llvm@18)/bin/clang`
- GCC 12 (Homebrew GCC 12.4.0) - available by `gcc-12` alias
- GCC 13 (Homebrew GCC 13.4.0) - available by `gcc-13` alias
- GCC 14 (Homebrew GCC 14.3.0) - available by `gcc-14` alias
- GNU Fortran 12 (Homebrew GCC 12.4.0) - available by `gfortran-12` alias
- GNU Fortran 13 (Homebrew GCC 13.4.0) - available by `gfortran-13` alias
- GNU Fortran 14 (Homebrew GCC 14.3.0) - available by `gfortran-14` alias
- Kotlin 2.1.10-release-473
- Node.js 22.17.0
- Perl 5.40.2
- Python3 3.13.5
- Ruby 3.3.8

### Package Management
- Bundler 2.6.9
- Carthage 0.40.0
- CocoaPods 1.16.2
- Homebrew 4.5.9
- NPM 10.9.2
- Pip3 25.1.1 (python 3.13)
- Pipx 1.7.1
- RubyGems 3.6.9
- Vcpkg 2025 (build from commit e86ec03236)
- Yarn 1.22.22

### Project Management
- Apache Ant 1.10.15
- Apache Maven 3.9.10
- Gradle 8.14.3

### Utilities
- 7-Zip 17.05
- aria2 1.37.0
- azcopy 10.29.1
- bazel 8.3.1
- bazelisk 1.26.0
- bsdtar 3.5.3 - available by 'tar' alias
- Curl 8.7.1
- Git 2.50.1
- Git LFS 3.7.0
- GitHub CLI 2.75.0
- GNU Tar 1.35 - available by 'gtar' alias
- GNU Wget 1.25.0
- gpg (GnuPG) 2.4.8
- jq 1.8.1
- OpenSSL 1.1.1w  11 Sep 2023
- Packer 1.13.1
- pkgconf 2.5.1
- Unxip 3.2
- yq 4.46.1
- zstd 1.5.7
- Ninja 1.13.1

### Tools
- AWS CLI 2.27.50
- AWS SAM CLI 1.142.1
- AWS Session Manager CLI 1.2.707.0
- Azure CLI 2.75.0
- Azure CLI (azure-devops) 1.0.2
- Bicep CLI 0.36.177
- Cmake 3.31.6
- CodeQL Action Bundle 2.22.1
- Fastlane 2.228.0
- SwiftFormat 0.57.0
- Xcbeautify 2.29.0
- Xcode Command Line Tools 16.4.0.0.1.1747106510
- Xcodes 1.6.2

### Linters

### Browsers
- Safari 18.5 (20621.2.5.11.8)
- SafariDriver 18.5 (20621.2.5.11.8)
- Google Chrome 138.0.7204.101
- Google Chrome for Testing 138.0.7204.94
- ChromeDriver 138.0.7204.94
- Mozilla Firefox 140.0.4
- geckodriver 0.36.0
- Selenium server 4.34.0

#### Environment variables
| Name            | Value                                   |
| --------------- | --------------------------------------- |
| CHROMEWEBDRIVER | /usr/local/share/chromedriver-mac-arm64 |
| EDGEWEBDRIVER   |                                         |
| GECKOWEBDRIVER  | /opt/homebrew/opt/geckodriver/bin       |

### Java
| Version              | Environment Variable |
| -------------------- | -------------------- |
| 11.0.27+6            | JAVA_HOME_11_arm64   |
| 17.0.15+6            | JAVA_HOME_17_arm64   |
| 21.0.7+6.0 (default) | JAVA_HOME_21_arm64   |

### Cached Tools

#### Ruby
- 3.1.7
- 3.2.8
- 3.3.8
- 3.4.4

#### Python
- 3.11.9
- 3.12.10
- 3.13.5

#### Node.js
- 18.20.8
- 20.19.3
- 22.17.0

#### Go
- 1.22.12
- 1.23.11
- 1.24.5

### Rust Tools
- Cargo 1.88.0
- Rust 1.88.0
- Rustdoc 1.88.0
- Rustup 1.28.2

#### Packages
- Clippy 0.1.88
- Rustfmt 1.8.0-stable

### PowerShell Tools
- PowerShell 7.4.11

#### PowerShell Modules
- Az: 12.5.0
- Pester: 5.7.1
- PSScriptAnalyzer: 1.24.0

### Xcode
| Version        | Build    | Path                            | Symlinks                                                                                  |
| -------------- | -------- | ------------------------------- | ----------------------------------------------------------------------------------------- |
| 26.0 (beta)    | 17A5241e | /Applications/Xcode_26_beta.app | /Applications/Xcode_26.0.0.app<br>/Applications/Xcode_26.0.app                            |
| 16.4           | 16F6     | /Applications/Xcode_16.4.app    | /Applications/Xcode_16.4.0.app                                                            |
| 16.3           | 16E140   | /Applications/Xcode_16.3.app    | /Applications/Xcode_16.3.0.app                                                            |
| 16.2           | 16C5032a | /Applications/Xcode_16.2.app    | /Applications/Xcode_16.2.0.app                                                            |
| 16.1           | 16B40    | /Applications/Xcode_16.1.app    | /Applications/Xcode_16.1.0.app                                                            |
| 16.0 (default) | 16A242d  | /Applications/Xcode_16.app      | /Applications/Xcode_16.0.0.app<br>/Applications/Xcode_16.0.app<br>/Applications/Xcode.app |

#### Installed SDKs
| SDK                       | SDK Name             | Xcode Version |
| ------------------------- | -------------------- | ------------- |
| macOS 15.0                | macosx15.0           | 16.0          |
| macOS 15.1                | macosx15.1           | 16.1          |
| macOS 15.2                | macosx15.2           | 16.2          |
| macOS 15.4                | macosx15.4           | 16.3          |
| macOS 15.5                | macosx15.5           | 16.4          |
| macOS 26.0                | macosx26.0           | 26.0          |
| iOS 18.0                  | iphoneos18.0         | 16.0          |
| iOS 18.1                  | iphoneos18.1         | 16.1          |
| iOS 18.2                  | iphoneos18.2         | 16.2          |
| iOS 18.4                  | iphoneos18.4         | 16.3          |
| iOS 18.5                  | iphoneos18.5         | 16.4          |
| iOS 26.0                  | iphoneos26.0         | 26.0          |
| Simulator - iOS 18.0      | iphonesimulator18.0  | 16.0          |
| Simulator - iOS 18.1      | iphonesimulator18.1  | 16.1          |
| Simulator - iOS 18.2      | iphonesimulator18.2  | 16.2          |
| Simulator - iOS 18.4      | iphonesimulator18.4  | 16.3          |
| Simulator - iOS 18.5      | iphonesimulator18.5  | 16.4          |
| Simulator - iOS 26.0      | iphonesimulator26.0  | 26.0          |
| tvOS 18.0                 | appletvos18.0        | 16.0          |
| tvOS 18.1                 | appletvos18.1        | 16.1          |
| tvOS 18.2                 | appletvos18.2        | 16.2          |
| tvOS 18.4                 | appletvos18.4        | 16.3          |
| tvOS 18.5                 | appletvos18.5        | 16.4          |
| tvOS 26.0                 | appletvos26.0        | 26.0          |
| Simulator - tvOS 18.0     | appletvsimulator18.0 | 16.0          |
| Simulator - tvOS 18.1     | appletvsimulator18.1 | 16.1          |
| Simulator - tvOS 18.2     | appletvsimulator18.2 | 16.2          |
| Simulator - tvOS 18.4     | appletvsimulator18.4 | 16.3          |
| Simulator - tvOS 18.5     | appletvsimulator18.5 | 16.4          |
| Simulator - tvOS 26.0     | appletvsimulator26.0 | 26.0          |
| watchOS 11.0              | watchos11.0          | 16.0          |
| watchOS 11.1              | watchos11.1          | 16.1          |
| watchOS 11.2              | watchos11.2          | 16.2          |
| watchOS 11.4              | watchos11.4          | 16.3          |
| watchOS 11.5              | watchos11.5          | 16.4          |
| watchOS 26.0              | watchos26.0          | 26.0          |
| Simulator - watchOS 11.0  | watchsimulator11.0   | 16.0          |
| Simulator - watchOS 11.1  | watchsimulator11.1   | 16.1          |
| Simulator - watchOS 11.2  | watchsimulator11.2   | 16.2          |
| Simulator - watchOS 11.4  | watchsimulator11.4   | 16.3          |
| Simulator - watchOS 11.5  | watchsimulator11.5   | 16.4          |
| Simulator - watchOS 26.0  | watchsimulator26.0   | 26.0          |
| visionOS 2.0              | xros2.0              | 16.0          |
| visionOS 2.1              | xros2.1              | 16.1          |
| visionOS 2.2              | xros2.2              | 16.2          |
| visionOS 2.4              | xros2.4              | 16.3          |
| visionOS 2.5              | xros2.5              | 16.4          |
| visionOS 26.0             | xros26.0             | 26.0          |
| Simulator - visionOS 2.0  | xrsimulator2.0       | 16.0          |
| Simulator - visionOS 2.1  | xrsimulator2.1       | 16.1          |
| Simulator - visionOS 2.2  | xrsimulator2.2       | 16.2          |
| Simulator - visionOS 2.4  | xrsimulator2.4       | 16.3          |
| Simulator - visionOS 2.5  | xrsimulator2.5       | 16.4          |
| Simulator - visionOS 26.0 | xrsimulator26.0      | 26.0          |
| DriverKit 24.0            | driverkit24.0        | 16.0          |
| DriverKit 24.1            | driverkit24.1        | 16.1          |
| DriverKit 24.2            | driverkit24.2        | 16.2          |
| DriverKit 24.4            | driverkit24.4        | 16.3          |
| DriverKit 24.5            | driverkit24.5        | 16.4          |
| DriverKit 25.0            | driverkit25.0        | 26.0          |

#### Installed Simulators
| OS           | Simulators                                                                                                                                                                                                                                                                                                                         |
| ------------ | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| iOS 18.0     | iPhone 16<br>iPhone 16 Plus<br>iPhone 16 Pro<br>iPhone 16 Pro Max<br>iPhone SE (3rd generation)<br>iPad (10th generation)<br>iPad Air 11-inch (M2)<br>iPad Air 13-inch (M2)<br>iPad mini (6th generation)<br>iPad Pro 11-inch (M4)<br>iPad Pro 13-inch (M4)                                                                        |
| iOS 18.1     | iPhone 16<br>iPhone 16 Plus<br>iPhone 16 Pro<br>iPhone 16 Pro Max<br>iPhone SE (3rd generation)<br>iPad (10th generation)<br>iPad Air 11-inch (M2)<br>iPad Air 13-inch (M2)<br>iPad mini (A17 Pro)<br>iPad Pro 11-inch (M4)<br>iPad Pro 13-inch (M4)                                                                               |
| iOS 18.2     | iPhone 16<br>iPhone 16 Plus<br>iPhone 16 Pro<br>iPhone 16 Pro Max<br>iPhone SE (3rd generation)<br>iPad (10th generation)<br>iPad Air 11-inch (M2)<br>iPad Air 13-inch (M2)<br>iPad mini (A17 Pro)<br>iPad Pro 11-inch (M4)<br>iPad Pro 13-inch (M4)                                                                               |
| iOS 18.3     | iPhone 16<br>iPhone 16 Plus<br>iPhone 16 Pro<br>iPhone 16 Pro Max<br>iPhone 16e<br>iPhone SE (3rd generation)<br>iPad (10th generation)<br>iPad (A16)<br>iPad Air 11-inch (M2)<br>iPad Air 11-inch (M3)<br>iPad Air 13-inch (M2)<br>iPad Air 13-inch (M3)<br>iPad mini (A17 Pro)<br>iPad Pro 11-inch (M4)<br>iPad Pro 13-inch (M4) |
| iOS 18.4     | iPhone 16<br>iPhone 16 Plus<br>iPhone 16 Pro<br>iPhone 16 Pro Max<br>iPhone 16e<br>iPhone SE (3rd generation)<br>iPad (10th generation)<br>iPad (A16)<br>iPad Air 11-inch (M2)<br>iPad Air 11-inch (M3)<br>iPad Air 13-inch (M2)<br>iPad Air 13-inch (M3)<br>iPad mini (A17 Pro)<br>iPad Pro 11-inch (M4)<br>iPad Pro 13-inch (M4) |
| iOS 18.5     | iPhone 16<br>iPhone 16 Plus<br>iPhone 16 Pro<br>iPhone 16 Pro Max<br>iPhone 16e<br>iPhone SE (3rd generation)<br>iPad (10th generation)<br>iPad (A16)<br>iPad Air 11-inch (M2)<br>iPad Air 11-inch (M3)<br>iPad Air 13-inch (M2)<br>iPad Air 13-inch (M3)<br>iPad mini (A17 Pro)<br>iPad Pro 11-inch (M4)<br>iPad Pro 13-inch (M4) |
| tvOS 18.0    | Apple TV<br>Apple TV 4K (3rd generation)<br>Apple TV 4K (3rd generation) (at 1080p)                                                                                                                                                                                                                                                |
| tvOS 18.1    | Apple TV<br>Apple TV 4K (3rd generation)<br>Apple TV 4K (3rd generation) (at 1080p)                                                                                                                                                                                                                                                |
| tvOS 18.2    | Apple TV<br>Apple TV 4K (3rd generation)<br>Apple TV 4K (3rd generation) (at 1080p)                                                                                                                                                                                                                                                |
| tvOS 18.4    | Apple TV<br>Apple TV 4K (3rd generation)<br>Apple TV 4K (3rd generation) (at 1080p)                                                                                                                                                                                                                                                |
| tvOS 18.5    | Apple TV<br>Apple TV 4K (3rd generation)<br>Apple TV 4K (3rd generation) (at 1080p)                                                                                                                                                                                                                                                |
| watchOS 11.0 | Apple Watch SE (40mm) (2nd generation)<br>Apple Watch SE (44mm) (2nd generation)<br>Apple Watch Series 10 (42mm)<br>Apple Watch Series 10 (46mm)<br>Apple Watch Ultra 2 (49mm)                                                                                                                                                     |
| watchOS 11.1 | Apple Watch SE (40mm) (2nd generation)<br>Apple Watch SE (44mm) (2nd generation)<br>Apple Watch Series 10 (42mm)<br>Apple Watch Series 10 (46mm)<br>Apple Watch Ultra 2 (49mm)                                                                                                                                                     |
| watchOS 11.2 | Apple Watch SE (40mm) (2nd generation)<br>Apple Watch SE (44mm) (2nd generation)<br>Apple Watch Series 10 (42mm)<br>Apple Watch Series 10 (46mm)<br>Apple Watch Ultra 2 (49mm)                                                                                                                                                     |
| watchOS 11.4 | Apple Watch SE (40mm) (2nd generation)<br>Apple Watch SE (44mm) (2nd generation)<br>Apple Watch Series 10 (42mm)<br>Apple Watch Series 10 (46mm)<br>Apple Watch Ultra 2 (49mm)                                                                                                                                                     |
| watchOS 11.5 | Apple Watch SE (40mm) (2nd generation)<br>Apple Watch SE (44mm) (2nd generation)<br>Apple Watch Series 10 (42mm)<br>Apple Watch Series 10 (46mm)<br>Apple Watch Ultra 2 (49mm)                                                                                                                                                     |
| visionOS 2.0 | Apple Vision Pro                                                                                                                                                                                                                                                                                                                   |
| visionOS 2.1 | Apple Vision Pro                                                                                                                                                                                                                                                                                                                   |
| visionOS 2.2 | Apple Vision Pro                                                                                                                                                                                                                                                                                                                   |
| visionOS 2.3 | Apple Vision Pro                                                                                                                                                                                                                                                                                                                   |
| visionOS 2.4 | Apple Vision Pro                                                                                                                                                                                                                                                                                                                   |
| visionOS 2.5 | Apple Vision Pro                                                                                                                                                                                                                                                                                                                   |

### Android
| Package Name               | Version                                                                                                                                                                                                                                                                                     |
| -------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Android Command Line Tools | 16.0                                                                                                                                                                                                                                                                                        |
| Android Emulator           | 35.6.11                                                                                                                                                                                                                                                                                     |
| Android SDK Build-tools    | 36.0.0<br>35.0.0 35.0.1                                                                                                                                                                                                                                                                     |
| Android SDK Platforms      | android-36 (rev 2)<br>android-35-ext15 (rev 1)<br>android-35-ext14 (rev 1)<br>android-35 (rev 2)<br>android-34-ext8 (rev 1)<br>android-34-ext12 (rev 1)<br>android-34-ext11 (rev 1)<br>android-34-ext10 (rev 1)<br>android-34 (rev 3)<br>android-33-ext5 (rev 1)<br>android-33-ext4 (rev 1) |
| Android SDK Platform-Tools | 36.0.0                                                                                                                                                                                                                                                                                      |
| Android Support Repository | 47.0.0                                                                                                                                                                                                                                                                                      |
| CMake                      | 3.31.5                                                                                                                                                                                                                                                                                      |
| Google Play services       | 49                                                                                                                                                                                                                                                                                          |
| Google Repository          | 58                                                                                                                                                                                                                                                                                          |
| NDK                        | 26.3.11579264<br>27.2.12479018 (default)<br>28.2.13676358                                                                                                                                                                                                                                   |

#### Environment variables
| Name                    | Value                                               |
| ----------------------- | --------------------------------------------------- |
| ANDROID_HOME            | /Users/runner/Library/Android/sdk                   |
| ANDROID_NDK             | /Users/runner/Library/Android/sdk/ndk/27.2.12479018 |
| ANDROID_NDK_HOME        | /Users/runner/Library/Android/sdk/ndk/27.2.12479018 |
| ANDROID_NDK_LATEST_HOME | /Users/runner/Library/Android/sdk/ndk/28.2.13676358 |
| ANDROID_NDK_ROOT        | /Users/runner/Library/Android/sdk/ndk/27.2.12479018 |
| ANDROID_SDK_ROOT        | /Users/runner/Library/Android/sdk                   |
