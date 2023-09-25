import NIOSSL
import Fluent
import FluentSQLiteDriver
import Vapor

// configures your application
public func configure(_ app: Application) async throws {
    app.logger.logLevel = .debug
    
    // uncomment to serve files from /Public folder
    app.logger.debug("app.directory.publicDirectory: \(app.directory.publicDirectory)")
    app.logger.debug("app.directory.workingDirectory: \(app.directory.workingDirectory)")
    
    app.middleware.use(FileMiddleware(publicDirectory: app.directory.publicDirectory))

    // https://docs.vapor.codes/zh/fluent/overview/#sqlite
    app.databases.use(.sqlite(.file("db.sqlite")), as: .sqlite)

    // https://docs.vapor.codes/zh/fluent/overview/#migrate
    app.migrations.add(CreateUser())
}
