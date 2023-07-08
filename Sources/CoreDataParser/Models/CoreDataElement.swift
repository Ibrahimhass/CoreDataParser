//
//  CoreDataElement.swift
//  CoreDataParser
//
//  Created by Ibrahim Hassan on 08/07/23.
//

import Foundation

public struct CoreDataElement: CoreDataDecodable {
    public let name: String
    public let positionX: Float
    public let width: Float
    public let height: Float
    
    static func decode(_ xml: XMLIndexerType) throws -> CoreDataElement {
        let container = xml.container(keys: CodingKeys.self)
        
        return CoreDataElement(
            name: try container.attribute(of: .name),
            positionX: try container.attribute(of: .positionX),
            width: try container.attribute(of: .width),
            height: try container.attribute(of: .height)
        )
    }
}
