//
//  CreateModelable.swift
//  json-encode
//
//  Created by Hung Le on 6/16/16.
//  Copyright © 2016 Hung Le. All rights reserved.
//

import Foundation
import Argo
import Curry

protocol JSONModelCreating {
    associatedtype CreatableType = Self
    static func createFromJSONData(data : NSData) throws -> CreatableType
}

extension JSONModelCreating where CreatableType : Decodable {
    typealias Type = CreatableType
    typealias ReturnType = CreatableType.DecodedType
    static func createFromJSONData(data : NSData) throws -> ReturnType {
        let anyObject = try NSJSONSerialization.JSONObjectWithData(data, options: [])
        let json = JSON(anyObject)
        let decodeResult: Decoded<ReturnType> = Type.decode(json)
        var object : ReturnType
        switch decodeResult {
        case .Success(let mObject):
            object = mObject
        case .Failure(let error):
            throw error
        }
        return object
    }
}