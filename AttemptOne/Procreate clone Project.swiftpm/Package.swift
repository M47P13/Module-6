// swift-tools-version: 5.8

// WARNING:
// This file is automatically generated.
// Do not edit it by hand because the contents will be replaced.

import PackageDescription
import AppleProductTypes

let package = Package(
    name: "Procreate clone Project",
    platforms: [
        .iOS("16.0")
    ],
    products: [
        .iOSApplication(
            name: "Procreate clone Project",
            targets: ["AppModule"],
            bundleIdentifier: "Module-6.Procreate-clone-Project",
            teamIdentifier: "G89MJGQDYM",
            displayVersion: "1.0",
            bundleVersion: "1",
            appIcon: .placeholder(icon: .bowl),
            accentColor: .presetColor(.indigo),
            supportedDeviceFamilies: [
                .pad,
                .phone
            ],
            supportedInterfaceOrientations: [
                .portrait,
                .landscapeRight,
                .landscapeLeft,
                .portraitUpsideDown(.when(deviceFamilies: [.pad]))
            ],
            appCategory: .productivity
        )
    ],
    targets: [
        .executableTarget(
            name: "AppModule",
            path: "."
        )
    ]
)