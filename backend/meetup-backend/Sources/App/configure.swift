import FluentMySQL
import Vapor

/// Called before your application initializes.
public func configure(_ config: inout Config, _ env: inout Environment, _ services: inout Services) throws {
    /// Register providers first
    try services.register(FluentMySQLProvider())

    /// Register routes to the router
    let router = EngineRouter.default()
    try routes(router)
    services.register(router, as: Router.self)

    /// Register middleware
    var middlewares = MiddlewareConfig() // Create _empty_ middleware config
    
    // CORS Middleware
    let corsConfig = CORSMiddleware.Configuration(allowedOrigin: .all,
                                                  allowedMethods: [.POST, .GET],
                                                  allowedHeaders: [.contentType, .accept])
    let coresMiddleware = CORSMiddleware(configuration: corsConfig)
    middlewares.use(coresMiddleware)
    
    /// middlewares.use(FileMiddleware.self) // Serves files from `Public/` directory
    middlewares.use(ErrorMiddleware.self) // Catches errors and converts to HTTP response
    
    services.register(middlewares)
    
    // Environment Variables: When running locally, set these in the Scheme    
    // Database ENV's
    let dbH = Environment.get("DB_HOST")
    guard let dbHost = dbH else {
        fatalError("Missing Database Host")
    }
    
    let dbP = Environment.get("DB_PORT")
    guard let dbPort = dbP else {
        fatalError("Missing Database Port")
    }
    
    let dbU = Environment.get("DB_USER")
    guard let dbUser = dbU else {
        fatalError("Missing Database User")
    }
    
    let dbPa = Environment.get("DB_PASS")
    guard let dbPass = dbPa else {
        fatalError("Missing Database Pass")
    }
    
    let dbN = Environment.get("DB_NAME")
    guard let dbName = dbN else {
        fatalError("Missing Database Name")
    }

    // Create Config for MySQL Database
    let dbConfig = MySQLDatabaseConfig(hostname: dbHost, port: Int(dbPort)!, username: dbUser, password: dbPass, database: dbName)
    let mysql = MySQLDatabase(config: dbConfig)
    
    /// Register the configured SQLite database to the database config.
    var databases = DatabasesConfig()
    databases.add(database: mysql, as: .mysql)
    services.register(databases)

    /// Configure migrations
    var migrations = MigrationConfig()
    migrations.add(model: User.self, database: .mysql)
    services.register(migrations)

}
