//
//  photoModel.swift
//  CloudDemo
//
//  Created by mac on 2021/4/9.
//

import Foundation

protocol DefaultValue {
    associatedtype Value: Decodable
    static var defaultValue: Value { get }
}

@propertyWrapper
struct Default<T: DefaultValue> {
    var wrappedValue: T.Value
}

extension Default: Decodable {
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        wrappedValue = (try? container.decode(T.Value.self)) ?? T.defaultValue
    }
}

extension KeyedDecodingContainer {
    func decode<T>( _ type: Default<T>.Type, forKey key: Key) throws -> Default<T> where T: DefaultValue {
        try decodeIfPresent(type, forKey: key) ?? Default(wrappedValue: T.defaultValue)
    }
}

extension Int {
    enum Zero: DefaultValue {
        static let defaultValue = 0
    }
}

extension String {
    enum Empty: DefaultValue {
        static let defaultValue = ""
    }
}

extension Default {
    typealias Zero = Default<Int.Zero>
    typealias Empty = Default<String.Empty>
}

struct photoModel: Decodable {
    var albumId: Int?
    var id: Int?
    var title: String?
    var url: String?
    var thumbnailUrl: String?
    
    enum CodingKeys: String, CodingKey {
        case albumId = "albumId"
        case id = "id"
        case title = "title"
        case url = "url"
        case thumbnailUrl = "thumbnailUrl"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        albumId = try values.decodeIfPresent(Int.self, forKey: .albumId) ?? 0
        id = try values.decodeIfPresent(Int.self, forKey: .id) ?? 0
        title = try values.decodeIfPresent(String.self, forKey: .title) ?? ""
        url = try values.decodeIfPresent(String.self, forKey: .url) ?? ""
        thumbnailUrl = try values.decodeIfPresent(String.self, forKey: .thumbnailUrl) ?? ""
    }
}
