//
//  DetailRouter.swift
//  UIKitVIPStudy
//
//  Created by Marcelo de Araújo on 05/12/2023.
//

import UIKit

class DetailRouter {

    weak var viewController: DetailViewController?
    
    init(viewController: DetailViewController) {
        self.viewController = viewController
    }
    
}


extension DetailRouter: DetailRoutingLogic {
    
    func navigateToGithub(userID: String) {
        if let url = URL(string: "https://github.com/\(userID)") {
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url, options: [:])
            }
        }
    }
    
}
