//
//  DetailConfigurator.swift
//  UIKitVIPStudy
//
//  Created by Marcelo de Araújo on 05/12/2023.
//

import Foundation

final class DetailConfigurator {
    
    static let shared = DetailConfigurator()
    private init() {}
    
    func configure(viewController: DetailViewController) {
        let router = DetailRouter(viewController: viewController)
        let presenter = DetailPresenter(viewController: viewController)
        let interactor = DetailInteractor(presenter: presenter)
        
        viewController.interactor = interactor
        viewController.router = router
    }
}
