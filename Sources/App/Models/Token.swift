//
//  Token.swift
//  
//
//  Created by lory on 2023/9/23.
//

import Fluent
import Vapor

// 建议将模型类标记为 final，以提高性能并简化一致性要求。
// 为了在路由闭包中直接返回 User，添加遵循 Content 协议
final class Token: Model, Content {
    
    static let schema = "tokens"

    @ID(key: .id)
    var id: UUID?
    
    @Field(key: "token")
    var token: String
    
    @Field(key: "token_type")
    var tokenType: String
    
    @Field(key: "revoked")
    var revoked: Int
    
    @Field(key: "expired")
    var expired: Int
    
    @Field(key: "user_id")
    var userId: String
    
    init() { }
    
    init(token: String, tokenType: String, revoked: Int, expired: Int, userId: String) {
        self.token = token
        self.tokenType = tokenType
        self.revoked = revoked
        self.expired = expired
        self.userId = userId
    }
}
