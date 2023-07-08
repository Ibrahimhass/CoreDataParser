import XCTest
@testable import CoreDataParser

final class CoreDataParserTests: XCTestCase {
    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        let xmlString =
            """
            <?xml version="1.0" encoding="UTF-8" standalone="yes"?>
            <model type="com.apple.IDECoreDataModeler.DataModel" documentVersion="1.0" lastSavedToolsVersion="21754" systemVersion="22F82" minimumToolsVersion="Xcode 7.3" sourceLanguage="Swift" userDefinedModelVersionIdentifier="">
                <entity name="About" representedClassName="About" syncable="YES">
                    <attribute name="descnews" optional="YES" syncable="YES"/>
                </entity>
            </model>
            """
        
        if let result = try? CoreDataModelParser().parserModel(xml: xmlString) {
            XCTAssertEqual(result.type, "com.apple.IDECoreDataModeler.DataModel")
            XCTAssertEqual(result.documentVersion, 1.0)
            XCTAssertEqual(result.lastSavedToolsVersion, 21754)
            XCTAssertEqual(result.systemVersion, "22F82")
            XCTAssertEqual(result.minimumToolsVersion, "Xcode 7.3")
            XCTAssertEqual(result.sourceLanguage, "Swift")
            XCTAssertEqual(result.userDefinedModelVersionIdentifier, "")
            
            // entity
            if let entity = result.entities.first {
                XCTAssertEqual(entity.name, "About")
                XCTAssertEqual(entity.representedClassName, "About")
                XCTAssertEqual(entity.syncable, true)
            } else {
                XCTFail()
            }            
        } else {
            XCTFail()
        }
    }
}
