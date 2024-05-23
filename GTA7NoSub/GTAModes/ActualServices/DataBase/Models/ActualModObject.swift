//
//  ModObject.swift
//  GTAModes
//
//  Created by Максим Педько on 20.08.2023.
//

import Foundation
import RealmSwift

struct ActualMod_Parser: Codable {
    let title: String
    let description: String
    let image: String
    
    let mod: String
    let filterTitle: String
    
    private enum ActualCodingKeysAndRename: String, CodingKey {
        case title = "irvnab"
        case description = "lxa06"
        case image = "kuibwl"
        case mod = "s43vjddzi"
        case filterTitle = "filterTitle"
    }
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: ActualCodingKeysAndRename.self)
        title = try container.decode(String.self, forKey: .title)
        description = try container.decode(String.self, forKey: .description)
        image = try container.decode(String.self, forKey: .image)
        mod = try container.decode(String.self, forKey: .mod)
        filterTitle = try container.decode(String.self, forKey: .filterTitle)
    }
}

struct ActualGTA5_Mods: Codable {
    let GTA5: [String: [ActualMod_Parser]]
    
    private enum ActualCodingKeysAndRename: String, CodingKey {
        case GTA5 = "iasgjbasmblsa"
    }
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: ActualCodingKeysAndRename.self)
        GTA5 = try container.decode([String: [ActualMod_Parser]].self, forKey: .GTA5)
    }
}

public struct ActualModItem {
    
    public var title: String = ""
    public var description: String = ""
    public var imagePath: String = ""
    public var modPath: String = ""
    public var filterTitle: String = ""
  
    init(
        title: String,
        description: String,
        imagePath: String,
        modPath: String,
        filterTitle: String
    ) {
        self.title = title
        self.description = description
        self.imagePath = imagePath
        self.modPath = modPath
        self.filterTitle = filterTitle
    }
    
}

public final class ActualModObject: Object {
    
    func actualOneCheck() -> Int{
        var checkOne = 93 + 3 * 2
        var checkTwo = checkOne - 22
        checkTwo += 11
        return checkTwo
    }
    
    
    @objc dynamic var titleMod: String = ""
    @objc dynamic var descriptionMod: String = ""
    @objc dynamic var imagePath: String = ""
    @objc dynamic var modPath: String = ""
    @objc dynamic var filterTitle: String = ""
    
    convenience init(
        titleMod: String,
        descriptionMod: String,
        imagePath: String,
        modPath: String,
        filterTitle: String
    ) {
        self.init()
        
        self.titleMod = titleMod
        self.descriptionMod = descriptionMod
        self.imagePath = imagePath
        self.modPath = modPath
        self.filterTitle = filterTitle
        
    }
    
    var lightweightRepresentation: ActualModItem {
        return ActualModItem(
            title: titleMod,
            description: descriptionMod,
            imagePath: imagePath,
            modPath: modPath,
            filterTitle: filterTitle
        )
    }
}



