//
//  ActualFakeLoaderController.swift
//  GTAModes
//
//  Created by Vladimir Khalin on 01.05.2024.
//

import Foundation
import UIKit

class ActualFakeLoader: UIViewController {
    var fakeLoaderView: CircularFakeLoaderView!
    
    override func viewDidLoad() {
       
        super.viewDidLoad()
        
       //    actualBackgroundAlertView()
        //   setupFakeLoaderView(duration: 2)
        
    }
    func actualBackgroundAlertView() {
        let alertBackgroundView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height))
        alertBackgroundView.backgroundColor = .black.withAlphaComponent(0.65)
        alertBackgroundView.actualAddBlurEffect()
        view.addSubview(alertBackgroundView)
    }
    
    func setupFakeLoaderView(duration: TimeInterval) {
        fakeLoaderView = CircularFakeLoaderView(frame: CGRect(x: view.frame.width / 2 - 80, y: view.frame.height / 2 - 80, width: 160, height: 160))
        view.addSubview(fakeLoaderView)
        fakeLoaderView.actualStartAnimation(duration: duration)
    }
}
