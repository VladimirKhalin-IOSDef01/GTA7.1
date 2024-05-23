
import Foundation
import Combine
import RealmSwift

public enum ActualGameSelected: String, CaseIterable {
    
    case gta6 = "GTA6"
    case gta5 = "GTA5"
    case gtaVC = "GTAVC"
    case gtaSA = "GTASA"
    
  // MARK: Select Title Name
//    private enum CodingKeys : String, CodingKey {
//          case gta6 = "Version 6"
//          case gta5 = "Version 5"
//          case gtaVC = "Version VC"
//          case gtaSA = "Version SA"
//    }
    
}

protocol ActualGSModelNavigationHandler: AnyObject {
    
    func actualGsModelDidRequestToGameModes(_ model: ActualGSModel, gameVersion: String)
    func actualGsModelDidRequestToBack(_ model: ActualGSModel)
    
}

final class ActualGSModel {
    public var hideSpiner: (() -> Void)?
    
    var reloadData: AnyPublisher<Void, Never> {
      reloadDataSubject
        .receive(on: DispatchQueue.main)
        .eraseToAnyPublisher()
    }
    var menuItems: [ActualMainItem] = []
    
    private let navigationHandler: ActualGSModelNavigationHandler
    private let reloadDataSubject = PassthroughSubject<Void, Never>()
    private let defaults = UserDefaults.standard
    
    init(
        navigationHandler: ActualGSModelNavigationHandler
    ) {
        
        self.navigationHandler = navigationHandler
        ActualDBManager.shared.delegate = self
        if let isLoadedData = defaults.value(forKey: "gta_isReadyGameList") as? Bool, isLoadedData {
            actualFetchData()
        }
    }
    
    public func actualSelectedItems(index: Int) {
        navigationHandler.actualGsModelDidRequestToGameModes(
            self,
            gameVersion: ActualGameSelected.allCases[index].rawValue
        )
    }
    
    public func actualBackAction_Proceed() {
        navigationHandler.actualGsModelDidRequestToBack(self)
    }
    
    func actualFetchData() {
        do {
            let realm = try Realm()
            let menuItem = realm.objects(ActualMainItemObject.self)
            let valueList = menuItem.filter { $0.rawTypeItem == "gameList"}
            let trueValueList = valueList.map { $0.lightweightRepresentation }
       
            trueValueList.forEach { [weak self] value in
                guard let self = self else { return }
                
                self.menuItems.append(value)
            }
            reloadDataSubject.send()
            hideSpiner?()
        } catch {
            print("Error saving data to Realm: \(error)")
        }
    }
    
}

extension ActualGSModel: ActualDBManagerDelegate {
    func actualIsReadyMain() {
        actualfullHouseRefresh()
    }
    
    func actualIsReadyGameList() {
        actualfullHouseRefresh()
        actualFetchData()
    }
    
    func actualIsReadyGameCodes() {
        actualfullHouseRefresh()
    }
    
    func actualIsReadyMissions() {
        actualfullHouseRefresh()
    }
    
    func actualIsReadyGTA5Mods() { 
        actualfullHouseRefresh()
    }
    
    func actualfullHouseRefresh() -> Int{
        
    var fullHouseRefreshOne = 1297 + 337 * 43
    var fullHouseRefreshTwo = fullHouseRefreshOne - 277
        fullHouseRefreshTwo += 1234
    return fullHouseRefreshTwo
    }
    
}

