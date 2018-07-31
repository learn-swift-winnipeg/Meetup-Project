// swift-tools-version:4.0
import PackageDescription

let package = Package(
    name: "meetup-backend",
    dependencies: [
        // 💧 A server-side Swift web framework.
        .package(url: "https://github.com/vapor/vapor.git", from: "3.0.0"),

        // 🐬 Pure Swift MySQL client built on non-blocking, event-driven sockets.
        .package(url: "https://github.com/vapor/fluent-mysql.git", from: "3.0.0"),

        // 🔒 i don't know if this is pure Swift, but heres a lock...
        .package(url: "https://github.com/vapor/auth.git", from: "2.0.0-rc.5")
    ],
    targets: [
        .target(name: "App", dependencies: ["FluentMySQL", "Vapor", "Authentication"]),
        .target(name: "Run", dependencies: ["App"]),
        .testTarget(name: "AppTests", dependencies: ["App"])
    ]
)

