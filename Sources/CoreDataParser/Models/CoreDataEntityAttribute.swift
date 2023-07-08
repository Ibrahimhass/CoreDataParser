//
//  CoreDataEntityAttribute.swift
//  CoreDataParser
//
//  Created by Ibrahim Hassan on 08/07/23.
//

import Foundation
import SWXMLHash

public enum AttributeType: XMLAttributeDecodable, KeyDecodable {
    case integer16
    case integer32
    case integer64
    case decimal
    case double
    case float
    case string
    case boolean
    case date
    case binary
    case uuid
    case uri
    case transformable

    public func encode(to encoder: Encoder) throws { fatalError() }

    static func decode(_ attribute: XMLAttribute) throws -> AttributeType {
        switch attribute.text {
        case "Integer 16": return .integer16
        case "Integer 32": return .integer32
        case "Integer 64": return .integer64
        case "Decimal": return .decimal
        case "Double": return .double
        case "Float": return .float
        case "String": return .string
        case "Boolean": return .boolean
        case "Date": return .date
        case "Binary": return .binary
        case "UUID": return .uuid
        case "URI": return .uri
        case "Transformable": return .transformable
            
        default: throw XMLDeserializationError.implementationIsMissing(method: attribute.text)
        }
    }
}

public struct CoreDataEntityAttribute: CoreDataDecodable {
    public let name: String
    public let optional: Bool
    public let attributeType: AttributeType?
    public let defaultValueString: String?
    public let usesScalarValueType: Bool?
    
    static func decode(_ xml: XMLIndexerType) throws -> CoreDataEntityAttribute {
        let container = xml.container(keys: CodingKeys.self)

        return CoreDataEntityAttribute(
            name: try container.attribute(of: .name),
            optional: container.attributeIfPresent(of: .optional) ?? false,
            attributeType: container.attributeIfPresent(of: .attributeType),
            defaultValueString: container.attributeIfPresent(of: .defaultValueString),
            usesScalarValueType: container.attributeIfPresent(of: .usesScalarValueType)
        )
    }
}
