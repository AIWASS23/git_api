//
//  DetailPresenter.swift
//  UIKitVIPStudy
//
//  Created by Marcelo de Araújo on 05/12/2023.
//

import Foundation

typealias DetailPresenterInput = DetailInteractorOutput

protocol DetailPresenterOutput: AnyObject {
    func displayUserDetail(viewModel: DetailModel.DisplayUserInfoDetails.ViewModel)
}

final class DetailPresenter {
    
    weak var viewController: DetailPresenterOutput?
    
    init(viewController: DetailPresenterOutput) {
        self.viewController = viewController
    }
}


extension DetailPresenter {}

extension DetailPresenter: DetailPresenterInput {

    func convertResponseFormat(userInfoDetails: UserInfo?) {
        guard let userInfoDetails = userInfoDetails else { return }
        
        let tableViewData = [
            ("Identidade", userInfoDetails.id),
            ("Nome", userInfoDetails.name),
            ("Apresentação", userInfoDetails.bio),
            ("Localização", userInfoDetails.location),
            ("Seguidores", "\(userInfoDetails.followers)"),
            ("Seguindo", "\(userInfoDetails.following)"),
            ("Repositório Público", "\(userInfoDetails.publicRepositories)"),
            ("Gist Público", "\(userInfoDetails.publicGists)"),
        ]
        
        let viewModel = DetailModel.DisplayUserInfoDetails.ViewModel(tableViewData: tableViewData)
        self.viewController?.displayUserDetail(viewModel: viewModel)
    }
}
