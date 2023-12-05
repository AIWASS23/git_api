//
//  HomeConfigurator.swift
//  UIKitVIPStudy
//
//  Created by Marcelo de Araújo on 05/12/2023.
//

import Foundation

class HomeConfigurator {
    
    static let shared = HomeConfigurator()
    private init() {}
    
    func configure(viewController: HomeViewController) {
        let router = HomeRouter(viewController: viewController)
        let presenter = HomePresenter(viewController: viewController)
        let interactor = HomeInteractor(presenter: presenter)
        
        viewController.interactor = interactor
        viewController.router = router
    }
    
}
