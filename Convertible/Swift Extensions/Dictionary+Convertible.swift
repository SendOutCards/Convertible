//
//  Dictionary+Convertible.swift
//  Convertibles
//
//  Created by Bradley Hilton on 6/15/15.
//  Copyright © 2015 Skyvive. All rights reserved.
//

import Foundation

extension Dictionary : DataModelConvertible {}

extension Dictionary : JsonConvertible {
    
    public static func initializeWithJson(json: JsonValue, options: [ConvertibleOption]) throws -> Dictionary {
        switch json {
        case .Dictionary(let dictionary): return try resultFromDictionary(dictionary, options: options)
        default: throw ConvertibleError.CannotCreateType(type: self, fromJson: json)
        }
    }
    
    static func resultFromDictionary(dictionary: [JsonDictionaryKey : JsonValue], options: [ConvertibleOption]) throws -> Dictionary {
        var result = Dictionary<Key, Value>()
        for (key, value) in dictionary {
            guard let keyType = Key.self as? JsonDictionaryKeyInitializable.Type,
                let key = try keyType.initializeWithJsonDictionaryKey(key, options: options) as? Key else {
                throw ConvertibleError.NotJsonDictionaryKeyInitializable(type: Key.self)
            }
            guard let valueType = Value.self as? JsonInitializable.Type,
                let value = try valueType.initializeWithJson(value, options: options) as? Value else {
                throw ConvertibleError.NotJsonInitializable(type: Value.self)
            }
            result[key] = value
        }
        return result
    }
    
    public func serializeToJsonWithOptions(options: [ConvertibleOption]) throws -> JsonValue {
        var dictionary = [JsonDictionaryKey : JsonValue]()
        for (key, value) in self {
            guard let key = key as? JsonDictionaryKeySerializable else {
                throw ConvertibleError.NotJsonDictionaryKeySerializable(type: Key.self)
            }
            guard let value = value as? JsonSerializable else {
                throw ConvertibleError.NotJsonSerializable(type: Value.self)
            }
            let object = try value.serializeToJsonWithOptions(options)
            let jsonKey = try key.serializeToJsonDictionaryKeyWithOptions(options)
            dictionary[jsonKey] = object
        }
        return JsonValue.Dictionary(dictionary)
    }
    
}