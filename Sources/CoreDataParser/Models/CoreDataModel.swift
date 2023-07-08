//
//  CoreDataModel.swift
//  CoreDataParser
//
//  Created by Ibrahim Hassan on 08/07/23.
//

import Foundation

public struct CoreDataModel: CoreDataModelDocument, CoreDataDecodable {
    public let type: String
    public let documentVersion: Float
    public let minimumToolsVersion: String
    public let userDefinedModelVersionIdentifier: String
    public let sourceLanguage: String
    public let systemVersion: String
    public let lastSavedToolsVersion: Int
    public let entities: [CoreDataEntity]
    public let elements: [CoreDataElement]
    
    enum ElementsCodingKey: CodingKey { case element }
    
    static func decode(_ xml: XMLIndexerType) throws -> CoreDataModel {
        let container = xml.container(keys: MappedCodingKey.self).map { (key: CodingKeys) in
            let stringValue: String = {
                switch key {
                case .entities: return "entity"
                default: return key.stringValue
                }
            }()
            
            return MappedCodingKey(stringValue: stringValue)
        }
        
        let elementsContainer = container.nestedContainerIfPresent(of: .elements, keys: ElementsCodingKey.self)
        
        return CoreDataModel(
            type: try container.attribute(of: .type),
            documentVersion: try container.attribute(of: .documentVersion),
            minimumToolsVersion: try container.attribute(of: .minimumToolsVersion),
            userDefinedModelVersionIdentifier: try container.attribute(of: .userDefinedModelVersionIdentifier),
            sourceLanguage: try container.attribute(of: .sourceLanguage),
            systemVersion: try container.attribute(of: .systemVersion),
            lastSavedToolsVersion: try container.attribute(of: .lastSavedToolsVersion),
            entities: container.elementsIfPresent(of: .entities) ?? [],
            elements: elementsContainer?.elementsIfPresent(of: .element) ?? []
        )
    }
}
