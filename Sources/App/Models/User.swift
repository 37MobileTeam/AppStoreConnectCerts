//
//  User.swift
//
//
//  Created by lory on 2023/8/4.
//

import Fluent
import Vapor

// 建议将模型类标记为 final，以提高性能并简化一致性要求。
// 为了在路由闭包中直接返回 User，添加遵循 Content 协议
final class User: Model, Content {

    static let schema = "users"

    @ID(key: .id)
    var id: UUID?

    @Field(key: "email")
    var email: String
    
    @Field(key: "password")
    var password: String
    
    @Field(key: "nickname")
    var nickname: String
    
    @Field(key: "is_delete")
    var isDelete: Int
    
    @Field(key: "create_time")
    var createTime: String
    
    @Field(key: "update_time")
    var updateTime: String
    
    @Field(key: "role")
    var role: String

    init() { }

    init(email: String, password: String, nickname: String, isDelete: Int, createTime: String, updateTime: String, role: String) {
        self.email = email
        self.password = password
        self.nickname = nickname
        self.isDelete = isDelete
        self.createTime = createTime
        self.updateTime = updateTime
        self.role = role
    }
}
