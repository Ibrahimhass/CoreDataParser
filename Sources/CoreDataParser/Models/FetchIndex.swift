//
//  FetchIndex.swift
//  CoreDataParser
//
//  Created by Ibrahim Hassan on 08/07/23.
//

import Foundation
import SWXMLHash

public enum FetchIndexType: XMLAttributeDecodable, KeyDecodable {
    case binary
    case rTree

    public func encode(to encoder: Encoder) throws { fatalError() }

    static func decode(_ attribute: XMLAttribute) throws -> FetchIndexType {
        switch attribute.text {
        case "Binary": return .binary
        case "RTree": return .rTree

        default: throw XMLDeserializationError.implementationIsMissing(method: attribute.text)
        }
    }
}

public struct FetchIndex: CoreDataDecodable {
    let name: String
    let partialIndexPredicate: String?
    let fetchIndexElement: FetchIndexElement?
    
    static func decode(_ xml: XMLIndexerType) throws -> FetchIndex {
        let container = xml.container(keys: CodingKeys.self)

        return FetchIndex(
            name: try container.attribute(of: .name),
            partialIndexPredicate: container.attributeIfPresent(of: .partialIndexPredicate),
            fetchIndexElement: container.elementIfPresent(of: .fetchIndexElement)
        )
    }
}

public struct FetchIndexElement: CoreDataDecodable {
    let property: String
    let type: FetchIndexType
    let order: String
    
    static func decode(_ xml: XMLIndexerType) throws -> FetchIndexElement {
        let container = xml.container(keys: CodingKeys.self)

        return FetchIndexElement(
            property: try container.attribute(of: .property),
            type: try container.attribute(of: .type),
            order: try container.attribute(of: .order)
        )
    }
}
