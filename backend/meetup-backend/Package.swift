// swift-tools-version:4.0
import PackageDescription

let package = Package(
    name: "meetup-backend",
    dependencies: [
        // 💧 A server-side Swift web framework.
        .package(url: "https://github.com/vapor/vapor.git", from: "3.0.0"),

        // 🔵 Swift ORM (queries, models, relations, etc) built on MySQL.
        .package(url: "https://github.com/vapor/fluent-mysql.git", from: "3.0.1"),

        // 🔓 Auth is used to handle all the secure things
        .package(url: "https://github.com/vapor/auth.git", from: "2.0.0"),

        // ⛓ Vapor-Extensions is used for handling Environment Variables
        .package(url: "https://github.com/vapor-community/vapor-ext.git", from: "0.1.0"),
    ],
    targets: [
        .target(name: "App", dependencies: ["FluentMySQL", "Vapor", "Authentication", "VaporExt"]),
        .target(name: "Run", dependencies: ["App"]),
        .testTarget(name: "AppTests", dependencies: ["App"])
    ]
)

