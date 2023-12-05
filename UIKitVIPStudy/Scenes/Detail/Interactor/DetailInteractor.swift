//
//  DetailInteractor.swift
//  UIKitVIPStudy
//
//  Created by Marcelo de Araújo on 05/12/2023.
//

import Foundation

typealias DetailInteractorInput = DetailViewControllerOutput

protocol DetailInteractorOutput: AnyObject {
    func convertResponseFormat(userInfoDetails: UserInfo?)
}

final class DetailInteractor {
    
    var presenter: DetailInteractorOutput?

    init(presenter: DetailInteractorOutput) {
        self.presenter = presenter
    }
}

extension DetailInteractor: DetailInteractorInput {

    func passUserInfoToPresenter(request: DetailModel.DisplayUserInfoDetails.Request) {
        let userInfoDetails = request.data
        self.presenter?.convertResponseFormat(userInfoDetails: userInfoDetails)
    }
    
}
