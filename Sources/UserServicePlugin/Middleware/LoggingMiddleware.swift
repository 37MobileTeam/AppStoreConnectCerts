//
//  LoggingMiddleware.swift
//  
//
//  Created by lory on 2023/9/9.
//

import OpenAPIRuntime
import Logging
import Foundation

/// A middleware that prints request and response metadata.
struct LoggingMiddleware: ServerMiddleware {
    
    private let logger: Logger
    private let module: String
    
    init(logger: Logger, module: String) throws {
        self.logger = logger
        self.module = module
    }
    
    func intercept(
        _ request: Request,
        metadata: ServerRequestMetadata,
        operationID: String,
        next: (Request, ServerRequestMetadata) async throws -> Response
    ) async throws -> Response {
//        self.logger.info("[\(self.module)] \(request.method.name) \(request.path) \(request.query ?? "")")
        do {
            let response = try await next(request, metadata)
//            self.logger.info("[\(self.module)] Next response.statusCode: \(response.statusCode)")
            return response
        } catch {
//            self.logger.error("[\(self.module)] Error: \(error.localizedDescription)")
            throw error
        }
    }
}
