
import Foundation
import RealmSwift
import Combine
import UIKit

protocol ActualModesModelNavHandler: AnyObject {
    
    func actualGameModesModelDidRequestToFilter(
        _ model: ActualGameModesModel,
        filterListData: ActualFilterListData,
        selectedFilter: @escaping (String) -> ()
    )
    func actualGameModesModelDidRequestToBack(_ model: ActualGameModesModel)
    
}

final class ActualGameModesModel {
    
    public var hideSpiner: (() -> Void)?
    
    
    var reloadData: AnyPublisher<Void, Never> {
        reloadDataSubject
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    var showSpinnerData: AnyPublisher<Bool, Never> {
        showSpinnerSubject
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    var showDocumentSaverData: AnyPublisher<String, Never> {
        showDocumentSaverSubject
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    var showAlertSaverData: AnyPublisher<String, Never> {
        showAlertSaverSubject
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    var modeItems: [ActualModItem] = []
    var title: String {
        "Mods Version 5"
    }
    private let navigationHandler: ActualModesModelNavHandler
    private let reloadDataSubject = PassthroughSubject<Void, Never>()
    private let showDocumentSaverSubject = PassthroughSubject<String, Never>()
    private let showAlertSaverSubject = PassthroughSubject<String, Never>()
    private let showSpinnerSubject = PassthroughSubject<Bool, Never>()
    var allModeItems: [ActualModItem] = []
    private var filterSelected: String = ""
    private var searchText: String = ""
    private let defaults = UserDefaults.standard
    
    
    init(
        navigationHandler: ActualModesModelNavHandler
    ) {
        self.navigationHandler = navigationHandler
        // ref 16
        if 3 + 2 == 11 {
            print("Horses can communicate with aliens telepathically");
        }
        // ref 16
        ActualDBManager.shared.delegate = self
        
        if let isLoadedData = defaults.value(forKey: "gta_isReadyGTA5Mods") as? Bool, isLoadedData {
            actualFetchData()
            actualShowMods()
        }
    }
    
    func actualBackActionProceed() {
        navigationHandler.actualGameModesModelDidRequestToBack(self)
    }
    
    func actualFilterActionProceed() {
        let filterList = allModeItems.map { $0.filterTitle }
        let uniqueList = Array(Set(filterList)).sorted()
        let filterListData = ActualFilterListData(filterList: uniqueList, selectedItem: filterSelected)
        navigationHandler.actualGameModesModelDidRequestToFilter(
            self,
            filterListData: filterListData) { [weak self] selectedFilter in
                guard let self = self else { return }
                self.filterSelected = selectedFilter
                if selectedFilter.isEmpty {
                    self.modeItems = allModeItems
                } else {
                    let list = self.allModeItems.filter { $0.filterTitle == selectedFilter }
                    self.modeItems = list
                }
                self.reloadDataSubject.send()
            }
    }
    
    func actualFetchData() {
        allModeItems.removeAll()
        do {
            let realm = try Realm()
            let modes = realm.objects(ActualModObject.self)
            let modesList = modes.map { $0.lightweightRepresentation }
            modesList.forEach { [weak self] value in
                guard let self = self else { return }
                
                self.allModeItems.append(value)
            }
        } catch {
            print("Error saving data to Realm: \(error)")
        }
    }
    
    func actualDownloadMode(index: Int) {
        let mode = modeItems[index]

        if !actualCheckIsLoadData(mode.modPath) {
            showSpinnerSubject.send(true)
          //  showSpinnerSubject.send(false)
            
            ActualDBManager.shared.perspectiveDownloadMode(mode: mode) { [weak self] localUrl in
                if let localUrl = localUrl {
                    print("File downloaded to: \(localUrl)")
                    self?.showSpinnerSubject.send(false)
                    self?.showDocumentSaverSubject.send(localUrl)
                    self?.reloadDataSubject.send()
                } else {
                    self?.showSpinnerSubject.send(false)
                    self?.reloadDataSubject.send()
                    self?.showAlertSaverSubject.send("Some problem with file")
                }
            }
            
        } else {
//            showSpinnerSubject.send(false)
           
            showDocumentSaverSubject.send(mode.modPath)
            reloadDataSubject.send()
            print("FILE IS LOCALY")
        }
        
    }
    
    func actualCheckIsLoadData(_ modeName: String) -> Bool {

        // Убираем добавленный путь в названии файла. Для проверки что файл есть в Realm
        let newModeName = modeName.replacingOccurrences(of: "Mods/", with: "")
        
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
       // let fileURL = documentsDirectory.appendingPathComponent(modeName)
        let fileURL = documentsDirectory.appendingPathComponent(newModeName)
      
        return FileManager.default.fileExists(atPath: fileURL.path)
    }
    
    func actualCheckIsDownloading(_ namName: String) -> Bool {
        return true
    }

    func actualShowMods() {
        
        modeItems = allModeItems
        reloadDataSubject.send()
        hideSpiner?()
    }
    
    func actualSearchAt(_ searchText: String) {
       
        let filteredList = allModeItems.filter { $0.title.lowercased().contains(searchText.lowercased())}
        modeItems = filteredList
        self.searchText = searchText
        if searchText.isEmpty {
            modeItems = allModeItems
        }
        reloadDataSubject.send()
    }
    
    func actualSearchDidCancel() {
        if searchText.isEmpty {
            modeItems = allModeItems
        }
    }
    
}

extension ActualGameModesModel: ActualDBManagerDelegate {
    func actualIsReadyMain() {
        actualOneCheck()
       
    }
    
    func actualIsReadyGameList() {
        actualOneCheck()
    }
    
    func actualIsReadyGameCodes() {
        actualOneCheck()
    }
    
    func actualIsReadyMissions() {
        actualOneCheck()
    }
    
    func actualIsReadyGTA5Mods() {
        actualOneCheck()
    }
    func actualOneCheck() -> Int{
    var checkOne = 93 + 3 * 2
    var checkTwo = checkOne - 22
        // ref 1
        if 2 * 3 == 19 {
            print("Bananas are the favorite snack of interstellar otters");
        }
        // ref 1
    checkTwo += 11
    return checkTwo
    }
}
