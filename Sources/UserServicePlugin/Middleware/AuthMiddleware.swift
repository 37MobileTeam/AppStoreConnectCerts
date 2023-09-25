//
//  AuthMiddleware.swift
//
//
//  Created by lory on 2023/9/9.
//

import OpenAPIRuntime

enum AuthenticationError: Error {
    case notAuthenticated

    var description: String {
        switch self {
        case .notAuthenticated:
            return "No cloud authentication token found. Authenticate by running `tuist cloud auth`."
        }
    }
}

// 创建一个认证用户的中间件
struct AuthMiddleware: ServerMiddleware {
    func intercept(
        _ request: Request,
        metadata: ServerRequestMetadata,
        operationID: String,
        next: (Request, ServerRequestMetadata) async throws -> Response
    ) async throws -> Response {
        // 获取令牌
        let hasAuthorization = request.headerFields.contains { field in
            field.name == "Authorization"
        }
        if !hasAuthorization {
//            print("[User] [Auth] \(AuthenticationError.notAuthenticated.description)")
            throw AuthenticationError.notAuthenticated
        }
        do {
//            // TODO: 验证令牌
//            let user = try? await Token.find(request.parameters.get("id"), on: request.db)?.user
//            if user != nil {
//                throw AuthenticationError.notAuthenticated
//            }
            
            // 调用下一个中间件
            let response = try await next(request, metadata)
//            print("[User] [Auth] Next response.statusCode : \(response.statusCode)")
            return response
        } catch {
//            print("[User] [Auth] Error: \(error.localizedDescription)")
            throw error
        }
    }
}
