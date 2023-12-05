//
//  HomeRouter.swift
//  UIKitVIPStudy
//
//  Created by Marcelo de Araújo on 05/12/2023.
//

import UIKit

class HomeRouter {
    
    weak var viewController: HomeViewController?
    
    init(viewController: HomeViewController) {
        self.viewController = viewController
    }
}

extension HomeRouter: HomeRoutingLogic {
    
    func navigateToDetail(dataToPass: UserInfo, animated: Bool) {
        let detailViewController = DetailViewController(dataToReceive: dataToPass)
        self.viewController?.navigationController?.pushViewController(detailViewController, animated: animated)
    }
    
}
