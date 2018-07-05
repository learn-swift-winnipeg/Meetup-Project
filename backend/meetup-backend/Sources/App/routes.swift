import Vapor

/// Register your application's routes here.
public func routes(_ router: Router) throws {
    router.get("/health") { req -> String in
        return "Everything is fine..."
    }
}
