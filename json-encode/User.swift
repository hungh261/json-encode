//
//  User.swift
//  json-encode
//
//  Created by Hung Le on 6/15/16.
//  Copyright © 2016 Hung Le. All rights reserved.
//
import Foundation
import Argo
import Curry
import JSONCodable

enum UserRole : String {
    case Staff = "staff"
    case Manager = "manager"
}

extension UserRole : JSONEncodable {}
extension UserRole : Decodable {}

struct User {
    let token: String
    let role: UserRole
    let uuid: String
    let name: String
}

extension User : Decodable {
    static func decode(j: JSON) -> Decoded<User> {
        return curry(User.init)
            <^> j <| "token"
            <*> j <| "role"
            <*> j <| "uuid"
            <*> j <| "name"
    }
}


extension User : JSONModelCreating {
    typealias CreatableType = User
}


extension User : JSONDecodable {
    init(object: JSONObject) throws {
        let decoder = JSONDecoder(object: object)
        uuid = try decoder.decode("uuid")
        name = try decoder.decode("name")
        token = try decoder.decode("token")
        role = try decoder.decode("role")
    }
}

extension User : JSONEncodable {
    func toJSON() throws -> AnyObject {
        return try JSONEncoder.create({ (encoder) -> Void in
            try encoder.encode(token, key: "token")
            try encoder.encode(name, key: "name")
            try encoder.encode(uuid, key: "uuid")
            try encoder.encode(role.rawValue, key: "role")
        })
    }
}




