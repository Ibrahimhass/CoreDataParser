//
//  CoreDataRelationship.swift
//  CoreDataParser
//
//  Created by Ibrahim Hassan on 08/07/23.
//

import Foundation
import SWXMLHash

public enum DeletionRule: XMLAttributeDecodable, KeyDecodable {
    case noAction
    case nullify
    case cascade
    case deny
    
    public func encode(to encoder: Encoder) throws { fatalError() }
    
    static func decode(_ attribute: XMLAttribute) throws -> DeletionRule {
        switch attribute.text {
        case "No Action": return .noAction
        case "Nullify": return .nullify
        case "Cascade": return .cascade
        case "Deny": return .deny
            
        default: throw XMLDeserializationError.implementationIsMissing(method: attribute.text)
        }
    }
}

public struct CoreDataRelationship: CoreDataDecodable {
    let name: String
    let optional: Bool?
    let transient: Bool?
    let toMany: Bool?
    let maxCount: Int?
    let deletionRule: DeletionRule?
    let destinationEntity: String?
    let inverseName: String?
    let inverseEntity: String?

    static func decode(_ xml: XMLIndexerType) throws -> CoreDataRelationship {
        let container = xml.container(keys: CodingKeys.self)

        return CoreDataRelationship(
            name: try container.attribute(of: .name),
            optional: container.attributeIfPresent(of: .optional),
            transient: container.attributeIfPresent(of: .transient),
            toMany: container.attributeIfPresent(of: .toMany),
            maxCount: container.attributeIfPresent(of: .maxCount),
            deletionRule: container.attributeIfPresent(of: .deletionRule),
            destinationEntity: container.attributeIfPresent(of: .destinationEntity),
            inverseName: container.attributeIfPresent(of: .inverseName),
            inverseEntity: container.attributeIfPresent(of: .inverseEntity)
        )
    }
}
