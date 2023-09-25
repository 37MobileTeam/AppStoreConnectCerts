//
//  UserEntrypoint.swift
//  
//
//  Created by lory on 2023/9/9.
//

import Vapor
import Dispatch
import Logging
import OpenAPIRuntime
import OpenAPIVapor

/// This extension is temporary and can be removed once Vapor gets this support.
private extension Vapor.Application {
    static let baseExecutionQueue = DispatchQueue(label: "vapor.codes.entrypoint")
    
    func runFromAsyncMainEntrypoint() async throws {
        try await withCheckedThrowingContinuation { continuation in
            Vapor.Application.baseExecutionQueue.async { [self] in
                do {
                    try self.run()
                    continuation.resume()
                } catch {
                    continuation.resume(throwing: error)
                }
            }
        }
    }
}

enum Entrypoint {
    static func main() async throws {
        var env = try Environment.detect()
        try LoggingSystem.bootstrap(from: &env)
        
        // Create a Vapor application.
        let app = Application(env)
        
        // Create a ServerTransport using the Vapor application.
        let transport = VaporTransport(routesBuilder: app)
        
        
        // Create an instance of the handler type that conforms the generated APIProtocol.
        let handler = Handler()
        
        // Craete server Middleware
        let loggingMiddleware = try LoggingMiddleware(logger: app.logger, module: "User")
        let authMiddleware = AuthMiddleware()
        let permissionMiddleware = PermissionMiddleware()
        
        // Call the generated protocol function on the handler to configure the Vapor application.
        try handler.registerHandlers(on: transport, serverURL: Servers.server1(), middlewares: [permissionMiddleware, authMiddleware, loggingMiddleware])
        
        defer { app.shutdown() }
        
        do {
            try await configure(app)
        } catch {
            app.logger.report(error: error)
            throw error
        }
        try await app.runFromAsyncMainEntrypoint()
        
    }
}
