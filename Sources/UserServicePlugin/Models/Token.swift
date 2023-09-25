//
//  Token.swift
//  
//
//  Created by lory on 2023/9/9.
//

import Fluent
import Vapor

// 建议将模型类标记为 final，以提高性能并简化一致性要求。
// 为了在路由闭包中直接返回 Token，添加遵循 Content 协议
final class Token: Model, Content {
    
    static let schema = "tokens"

    @ID(key: .id)
    var id: UUID?

    @Field(key: "token")
    var token: String

    @Field(key: "user")
    var user: String

    init() { }

    init(id: UUID? = nil, token: String, user: String) {
        self.id = id
        self.token = token
        self.user = user
    }
}
