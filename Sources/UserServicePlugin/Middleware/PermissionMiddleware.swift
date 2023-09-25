//
//  PermissionMiddleware.swift
//  
//
//  Created by lory on 2023/9/9.
//

import OpenAPIRuntime


// 创建一个菜单权限的中间件
struct PermissionMiddleware: ServerMiddleware {
    func intercept(
        _ request: Request,
        metadata: ServerRequestMetadata,
        operationID: String,
        next: (Request, ServerRequestMetadata) async throws -> Response
    ) async throws -> Response {
        do {
//            // TODO: 获取用户
//            let user = try request.auth.require(User.self)
//            // TODO: 获取菜单
//            let menu = try Menu.find(request.parameters.get("menuID"), on: req.db).unwrap(or: Abort(.notFound))
//            // TODO: 验证权限
//            guard user.permissions.contains(where: menu.permissions.contains) else {
//                throw Abort(.forbidden)
//            }
//            print("TODO: 获取用户")
//            print("TODO: 获取菜单")
//            print("TODO: 验证权限")
            
            // 调用下一个中间件
            let response = try await next(request, metadata)
//            print("[User] [Permission] Next response.statusCode : \(response.statusCode)")
            return response
        } catch {
//            print("[User] [Permission] Error \(error.localizedDescription)")
            throw error
        }
    }
}
