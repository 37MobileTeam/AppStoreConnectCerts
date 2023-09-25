//===----------------------------------------------------------------------===//
//
// This source file is part of the SwiftOpenAPIGenerator open source project
//
// Copyright (c) 2023 Apple Inc. and the SwiftOpenAPIGenerator project authors
// Licensed under Apache License v2.0
//
// See LICENSE.txt for license information
// See CONTRIBUTORS.txt for the list of SwiftOpenAPIGenerator project authors
//
// SPDX-License-Identifier: Apache-2.0
//
//===----------------------------------------------------------------------===//
import OpenAPIRuntime
import OpenAPIVapor
import Vapor

// User provides a type that adopts `APIProtocol` (a generated protocol).
struct Handler: APIProtocol {
    func login(_ input: Operations.login.Input) async throws -> Operations.login.Output {
        let jwtToken =  Components.Schemas.JWTToken(token: "MyToken SDAWF23ewfs",
                                                    refreshToken: "refreshToken 123",
                                                    tokenValidTime: 3600,
                                                    refreshTokenValidTime: 7*24*3600)
        let userResponse = Components.Schemas.UserResponse(id:
                                                            "SDAWF23ewfs-sdfaf-adfwef",
                                                           photo: nil,
                                                           email: nil,
                                                           firstName: "lw",
                                                           lastName: "wei",
                                                           createdAt: Date(),
                                                           updatedAt: Date())
        return .ok(.init(body: .json(Components.Schemas.LoginResponse(jwt: jwtToken, user: userResponse))))
    }
    
    func refreshLogin(_ input: Operations.refreshLogin.Input) async throws -> Operations.refreshLogin.Output {
        return .ok(.init(body: .json(Components.Schemas.JWTToken())))
    }
    
    func register(_ input: Operations.register.Input) async throws -> Operations.register.Output {
        return .ok(Operations.register.Output.Ok())
    }
    
    func emailValidation(_ input: Operations.emailValidation.Input) async throws -> Operations.emailValidation.Output {
        return .ok(Operations.emailValidation.Output.Ok())
    }
    
    func emailValidationApprove(_ input: Operations.emailValidationApprove.Input) async throws -> Operations.emailValidationApprove.Output {
        // Return a OK response (HTTP status 200) with a JSON body, using a type-safe output.
        return .ok(.init(body: .json(Components.Schemas.EmailValidationApproveResponse())))
    }
    
    func forgetPassword(_ input: Operations.forgetPassword.Input) async throws -> Operations.forgetPassword.Output {
        return .ok(Operations.forgetPassword.Output.Ok())
    }
    
    func restoreAccount(_ input: Operations.restoreAccount.Input) async throws -> Operations.restoreAccount.Output {
        return .ok(Operations.restoreAccount.Output.Ok())
    }
    
    func changeEmail(_ input: Operations.changeEmail.Input) async throws -> Operations.changeEmail.Output {
        // Return a OK response (HTTP status 200) with a JSON body, using a type-safe output.
        return .ok(Operations.changeEmail.Output.Ok())
    }
    
    func getCurrentUser(_ input: Operations.getCurrentUser.Input) async throws -> Operations.getCurrentUser.Output {
        // Return a OK response (HTTP status 200) with a JSON body, using a type-safe output.
        return .ok(.init(body: .json(Components.Schemas.UserResponse())))
    }
    
    func getUser(_ input: Operations.getUser.Input) async throws -> Operations.getUser.Output {
        // Return a OK response (HTTP status 200) with a JSON body, using a type-safe output.
        return .ok(.init(body: .json(Components.Schemas.UserResponse())))
    }
    
    func updateUser(_ input: Operations.updateUser.Input) async throws -> Operations.updateUser.Output {
        // Return a OK response (HTTP status 200) with a JSON body, using a type-safe output.
        return .ok(.init(body: .json(Components.Schemas.UserResponse())))
    }
    
    func deleteUser(_ input: Operations.deleteUser.Input) async throws -> Operations.deleteUser.Output {
        
        // Return a OK response (HTTP status 200) with a JSON body, using a type-safe output.
        return .noContent(Operations.deleteUser.Output.NoContent())
    }
    
    func blockUser(_ input: Operations.blockUser.Input) async throws -> Operations.blockUser.Output {
        
        // Return a OK response (HTTP status 200) with a JSON body, using a type-safe output.
        return .noContent(Operations.blockUser.Output.NoContent())
    }
    
    func unblockUser(_ input: Operations.unblockUser.Input) async throws -> Operations.unblockUser.Output {
        
        // Return a OK response (HTTP status 200) with a JSON body, using a type-safe output.
        return .noContent(Operations.unblockUser.Output.NoContent())
    }
    
    func uploadUserPhoto(_ input: Operations.uploadUserPhoto.Input) async throws -> Operations.uploadUserPhoto.Output {

        // Return a OK response (HTTP status 200) with a JSON body, using a type-safe output.
        return .ok(.init(body: .json(Components.Schemas.UserResponse())))
    }
}

@main
struct Main {
    public static func main() async throws {
        try await Entrypoint.main()
    }
}
