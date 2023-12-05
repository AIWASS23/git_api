//
//  HomePresenter.swift
//  UIKitVIPStudy
//
//  Created by Marcelo de Araújo on 05/12/2023.
//

import Foundation

typealias HomePresenterInput = HomeInteractorOutput

protocol HomePresenterOutput: AnyObject {
    func displayUserProfile(viewModel: HomeModel.FetchUserInfo.ViewModel)
    func displayFailStatus()
    func prepareDataToPass(dataToPass: UserInfo)
}

class HomePresenter {
    
    weak var viewController: HomePresenterOutput?
    
    init(viewController: HomePresenterOutput) {
        self.viewController = viewController
    }
}

extension HomePresenter {}

extension HomePresenter: HomePresenterInput {

    func convertResponseFormat(response: HomeModel.FetchUserInfo.Response?) {
        guard let response = response else {
            self.viewController?.displayFailStatus()
            return
        }
        
        let viewModel = HomeModel.FetchUserInfo.ViewModel(
            imageURL: response.avatarUrl,
            id: response.login
        )
        
        let dataToPass = UserInfo(
            imageURL: response.avatarUrl,
            id: response.login,
            name: response.name,
            bio: response.bio,
            location: response.location,
            publicRepositories: response.publicRepos,
            publicGists: response.publicGists,
            followers: response.followers,
            following: response.following
        )
        
        self.viewController?.displayUserProfile(viewModel: viewModel)
        self.viewController?.prepareDataToPass(dataToPass: dataToPass)
    }

    func passFailStatus() {
        self.viewController?.displayFailStatus()
    }
}
