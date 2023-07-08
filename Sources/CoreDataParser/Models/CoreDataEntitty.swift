//
//  CoreDataEntitty.swift
//  CoreDataParser
//
//  Created by Ibrahim Hassan on 08/07/23.
//

import Foundation

public struct CoreDataEntity: CoreDataDecodable {
    public let name: String
    public let representedClassName: String
    public let syncable: Bool
    public let attributes: [CoreDataEntityAttribute]
    public let relationships: [CoreDataRelationship]
    
    static func decode(_ xml: XMLIndexerType) throws -> CoreDataEntity {
        let container = xml.container(keys: MappedCodingKey.self).map { (key: CodingKeys) in
            let stringValue: String = {
                switch key {
                case .attributes: return "attribute"
                case .relationships: return "relationship"
                default: return key.stringValue
                }
            }()
            
            return MappedCodingKey(stringValue: stringValue)
        }
        
        
        return CoreDataEntity(
            name: try container.attribute(of: .name),
            representedClassName: try container.attribute(of: .representedClassName),
            syncable: try container.attribute(of: .syncable),
            attributes: container.elementsIfPresent(of: .attributes) ?? [],
            relationships: container.elementsIfPresent(of: .relationships) ?? []
        )
    }
}
