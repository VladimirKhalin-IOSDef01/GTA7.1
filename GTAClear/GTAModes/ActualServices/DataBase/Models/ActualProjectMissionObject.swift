//
//  MissionObject.swift
//  GTAModes
//
//  Created by Максим Педько on 15.08.2023.
//

import Foundation
import RealmSwift

    struct ActualProjMissionCategory: Codable {
        let filter: String
        let name: String
        
        private enum ActualCodingKeysAndRename: String, CodingKey {
            case filter
            case name = "hfhju8900"
        }
        init(from decoder: Decoder) throws {
                let container = try decoder.container(keyedBy: ActualCodingKeysAndRename.self)
                filter = try container.decode(String.self, forKey: .filter)
                name = try container.decode(String.self, forKey: .name)
            }
    }

    // Define the Checklist struct to hold the list of missions.
    struct ActualChecklist: Codable {
        
        let missions: [ActualProjMissionCategory]
      
        // Specify the coding keys to match JSON structure.
        private enum ActualCodingKeysAndRename: String, CodingKey {
            case missions = "Cheklist"
        }
        init(from decoder: Decoder) throws {
               let container = try decoder.container(keyedBy: ActualCodingKeysAndRename.self)
               missions = try container.decode([ActualProjMissionCategory].self, forKey: .missions)
           }
    }

    // Define the top-level struct to match the JSON structure.
    struct ActualRoot: Codable {
        let rnfwruhr: ActualChecklist

        // Specify the coding keys to match JSON structure.
        private enum ActualCodingKeysAndRename: String, CodingKey {
            case rnfwruhr
        }
        init(from decoder: Decoder) throws {
              let container = try decoder.container(keyedBy: ActualCodingKeysAndRename.self)
              rnfwruhr = try container.decode(ActualChecklist.self, forKey: .rnfwruhr)
          }
    }


struct ActualMission_Parser: Codable {
    let mandatoryMission: ActualProjMissionCategory

    private enum ActualCodingKeysAndRename: String, CodingKey {
        case mandatoryMission = "rnfwruhr"
    }
    init(from decoder: Decoder) throws {
           let container = try decoder.container(keyedBy: ActualCodingKeysAndRename.self)
           mandatoryMission = try container.decode(ActualProjMissionCategory.self, forKey: .mandatoryMission)
       }
       
}

public struct ActualMissionItem {
    var categoryName: String = ""
    var missionName: String = ""
    var isCheck: Bool = false
    
    init(categoryName: String, missionName: String, isCheck: Bool) {
        self.categoryName = categoryName
        self.missionName = missionName
        self.isCheck = isCheck
    }
}

public final class ActualMissionObject: Object {
    
    @objc dynamic private(set) var id: String = UUID().uuidString.lowercased()
    @objc dynamic var category: String = ""
    @objc dynamic var name: String = ""
    @objc dynamic var isCheck: Bool = false
    
    override public static func primaryKey() -> String? {
        return #keyPath(ActualMissionObject.id)
    }

    convenience init(
        category: String,
        name: String,
        isCheck: Bool
    ) {
        self.init()
        self.category = category
        self.name = name
        self.isCheck = isCheck
    }
    
    var lightweightRepresentation: ActualMissionItem {
        return ActualMissionItem(categoryName: category, missionName: name, isCheck: isCheck)
       
    }
    
}



