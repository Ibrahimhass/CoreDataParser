//
//  CoreDataModelDocument.swift
//  CoreDataParser
//
//  Created by Ibrahim Hassan on 08/07/23.
//

import Foundation
import SWXMLHash

public protocol CoreDataModelDocument {
    var type: String { get }
    var documentVersion: Float { get }
    var minimumToolsVersion: String { get }
    var userDefinedModelVersionIdentifier: String { get }
    var sourceLanguage: String { get }
    var systemVersion: String { get }
    var lastSavedToolsVersion: Int { get }
    var entities: [CoreDataEntity] { get }
    var elements: [CoreDataElement] { get }
}
