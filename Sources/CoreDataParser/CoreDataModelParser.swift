//
//  CoreDataModelParser.swift
//  CoreDataParser
//
//  Created by Ibrahim Hassan on 07/07/23.
//

import Foundation
import SWXMLHash

protocol CoreDataDecodable: XMLDecodable, KeyDecodable {}

public class CoreDataModelParser {
    let xmlParser: XMLHash
    
    public init(detectParsingErrors: Bool = true) {
        xmlParser = XMLHash.config { options in
            options.detectParsingErrors = detectParsingErrors
        }
    }
    
    enum Keys: CodingKey { case model }
    
    public func parserModel(xml: String) throws -> CoreDataModel { try parseDocument(xml: xml) }
    
    func parseDocument<D: CoreDataModelDocument & CoreDataDecodable>(xml: String) throws -> D {
        return try parseDocument(xmlIndexer: xmlParser.parse(xml))
    }
    
    func parseDocument<D: CoreDataModelDocument & CoreDataDecodable>(xmlIndexer: XMLIndexerType) throws -> D {
        if let swxmlIndexer = xmlIndexer as? XMLIndexer {
            if let error = swxmlIndexer.error {
                throw error
            }
        }
        let container = xmlIndexer.container(keys: Keys.self)
        do {
            return try container.element(of: .model)
        } catch let error as ParsingError {
            throw Error.parsingError(error)
        } catch let error as IndexingError {
            throw Error.xmlError(error)
        } catch {
            throw error
        }
    }
    
    public enum Error: Swift.Error {
        case invalidFormatFile
        case parsingError(ParsingError)
        case xmlError(IndexingError)
    }
}


public extension XMLIndexer {
    var error: CoreDataModelParser.Error? {
        switch self {
        case .parsingError(let error):
            return .parsingError(error)
        case .xmlError(let error):
            return .xmlError(error)
        default:
            return nil
        }
    }
}
