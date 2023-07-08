# CoreDataParser
[![Swift 5.8](https://img.shields.io/badge/Swift-5.8-orange.svg?style=flat)](https://developer.apple.com/swift/)

A tool to translate `CoreDataModel` XML into Swift models.

## Installing

Adding CoreDataParser as a dependency is as easy as adding it to the `dependencies` value of your `Package.swift`.

```
dependencies: [
    .package(url: "https://github.com/Ibrahimhass/CoreDataParser",
    majorVersion: <majorVersion>, minor: <minor>)
]
```
## Parser CoreDataModel

From string content:
```swift
let simpleCoreDataXMLString = """
    <?xml version="1.0" encoding="UTF-8" standalone="yes"?>
    <model type="com.apple.IDECoreDataModeler.DataModel" documentVersion="1.0" lastSavedToolsVersion="21754" systemVersion="22F82" minimumToolsVersion="Xcode 7.3" sourceLanguage="Swift" userDefinedModelVersionIdentifier="">
        <entity name="About" representedClassName="About" syncable="YES">
            <attribute name="descnews" optional="YES" syncable="YES"/>
        </entity>
    </model>
    """

do {
  let coreDataModel = try CoreDataModelParser().parserModel(xml: simpleCoreDataXMLString)
} catch {
  print (error)
}
```

### Get the Core Data Entities

```swift
do {
    let coreDataModel = try CoreDataParser().parseModel(xml: simpleCoreDataXMLString)
    
    for entity in coreDataModel.entities {
        print (entity.name)
        // get attributes using entity.attributes
        // get relationships using entity.relationships
    }
} catch {
    print (error)
}
```


