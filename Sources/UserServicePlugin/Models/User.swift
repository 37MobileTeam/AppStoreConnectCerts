//
//  User.swift
//  
//
//  Created by lory on 2023/9/9.
//
import Fluent
import Vapor

// 建议将模型类标记为 final，以提高性能并简化一致性要求。
// 为了在路由闭包中直接返回 User，添加遵循 Content 协议
final class User: Model, Content, Authenticatable {
    
    static let schema = "users"

    @ID(key: .id)
    var id: UUID?

    @Field(key: "username")
    var username: String

    @Field(key: "password")
    var password: String
    
    
    @Field(key: "uid")
    var uid: String


    init() { }

    init(id: UUID? = nil, username: String, password: String, uid: String) {
        self.id = id
        self.username = username
        self.password = password
        self.uid = uid
    }
}
