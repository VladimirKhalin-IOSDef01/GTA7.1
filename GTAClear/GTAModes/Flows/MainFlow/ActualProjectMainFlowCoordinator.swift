
import Foundation
import UIKit

final class ActualProjectMainFlowCoordinator: NSObject, ActualProjectFlowCoordinator3862 {
  
    private weak var rootViewController: UIViewController?
    private weak var panPresentedViewController: UIViewController?
    private weak var presentedViewController: UIViewController?

    override init() {
        super.init()
    }
    
    //MARK: Start View Controlle
    
    func actualCreateFlow() -> UIViewController {
        let model = ActualMainModel(navigationHandler: self as ActualMainModelNavigationHandler)
        let controller = ActualMainViewControllerNew(model: model)
        rootViewController = controller
        
        return controller
    }
}

extension ActualProjectMainFlowCoordinator: ActualMainModelNavigationHandler {
    
    func actualMainModelDidRequestToModes(_ model: ActualMainModel) {
        let modelScreen = ActualMainModel(navigationHandler: self as ActualMainModelNavigationHandler)
        let model = ActualGameModesModel(navigationHandler: self as ActualModesModelNavHandler)
        let controller = ActualModesViewController(model: model, modelScreen: modelScreen)
        presentedViewController = controller
        rootViewController?.navigationController?.pushViewController(controller, animated: true)
    }
    
    func actualMainModelDidRequestToModesInfo(_ model: ActualMainModel) {
        let model = ActualGameModesModel(navigationHandler: self as ActualModesModelNavHandler)
        let controller = ActualModesInfoViewController(model: model)
        presentedViewController = controller
        rootViewController?.navigationController?.pushViewController(controller, animated: true)
    }
    
    func actualMainModelDidRequestToMap(_ model: ActualMainModel) {
        let controller = ActualGameMapViewController(navigationHandler: self as ActualMap_NavigationHandler)
        presentedViewController = controller
        rootViewController?.navigationController?.pushViewController(controller, animated: true)
    }
    
    func actualMainModelDidRequestToGameSelection(_ model: ActualMainModel) {
        let model = ActualGSModel(navigationHandler: self as ActualGSModelNavigationHandler)
        let controller = ActualGSViewController(model: model)
        presentedViewController = controller
        rootViewController?.navigationController?.pushViewController(controller, animated: true)
    }
    
    func actualMainModelDidRequestToChecklist(_ model: ActualMainModel) {
        let model = ActualChecklistModel(navigationHandler: self as ActualChecklistModelNavigationHandler)
        let controller = ActualChecklistViewController(model: model)
        presentedViewController = controller
        rootViewController?.navigationController?.pushViewController(controller, animated: true)
    }
    
}

extension ActualProjectMainFlowCoordinator: ActualGSModelNavigationHandler {
    
    func actualGsModelDidRequestToBack(_ model: ActualGSModel) {
        presentedViewController?.navigationController?.popViewController(animated: true)
    }
    
    
    func actualGsModelDidRequestToGameModes(_ model: ActualGSModel, gameVersion: String) {
        let model = ActualGameCheatsModel(versionGame: gameVersion, navigationHandler: self as ActualCheatsModelNavigationHandler)
        let controller = ActualGameCheatsViewController(model: model)
        presentedViewController?.navigationController?.pushViewController(controller, animated: true)
    }
    
}

extension ActualProjectMainFlowCoordinator: ActualChecklistModelNavigationHandler {
    
    
    func actualChecklistModelDidRequestToFilter(
        _ model: ActualChecklistModel,
        filterListData: ActualFilterListData,
        selectedFilter: @escaping (String) -> ()
    ) {
        let controller = ActualFilterViewController(
            filterListData: filterListData,
            selectedFilter: selectedFilter,
            navigationHandler: self as ActualFilterNavigationHandler
        )
        presentedViewController?.actualPresentPanCollection(controller)
        panPresentedViewController = controller
    }
    
    
    func actualChecklistModelDidRequestToBack(_ model: ActualChecklistModel) {
        presentedViewController?.navigationController?.popViewController(animated: true)
    }
    
}

extension ActualProjectMainFlowCoordinator: ActualCheatsModelNavigationHandler {
    func actualGameModesModelDidRequestToBack(_ model: ActualGameCheatsModel) {
        presentedViewController?.navigationController?.popViewController(animated: true)
    }
    
    func actualGameModesModelDidRequestToFilter(
        _ model: ActualGameCheatsModel,
        filterListData: ActualFilterListData,
        selectedFilter: @escaping (String) -> ()
        
    ) {
        let controller = ActualFilterViewController(
            filterListData: filterListData,
            selectedFilter: selectedFilter,
            navigationHandler: self as ActualFilterNavigationHandler
        )
        presentedViewController?.actualPresentPanCollection(controller)
        panPresentedViewController = controller
    }
    
}

extension ActualProjectMainFlowCoordinator: ActualFilterNavigationHandler {
    
    
    func actualFilterDidRequestToClose() {
        panPresentedViewController?.dismiss(animated: true)
    }
    
}

extension ActualProjectMainFlowCoordinator: ActualMap_NavigationHandler {
    
    func actualMapDidRequestToBack() {
        presentedViewController?.navigationController?.popViewController(animated: true)
    }
}

extension ActualProjectMainFlowCoordinator: ActualModesModelNavHandler {
    
    func actualGameModesModelDidRequestToFilter(_ model: ActualGameModesModel, filterListData: ActualFilterListData, selectedFilter: @escaping (String) -> ()) {
        let controller = ActualFilterViewController(
            filterListData: filterListData,
            selectedFilter: selectedFilter,
            navigationHandler: self as ActualFilterNavigationHandler
        )
        presentedViewController?.actualPresentPanCollection(controller)
        panPresentedViewController = controller
    }
    
    func actualGameModesModelDidRequestToBack(_ model: ActualGameModesModel) {
        presentedViewController?.navigationController?.popViewController(animated: true)
    }
}
