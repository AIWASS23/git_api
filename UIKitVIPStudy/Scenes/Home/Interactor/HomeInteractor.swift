//
//  ListInteractor.swift
//  UIKitVIPStudy
//
//  Created by Marcelo de Araújo on 05/12/2023.
//

import Foundation

typealias HomeInteractorInput = HomeViewControllerOutput

protocol HomeInteractorOutput: AnyObject {
    func convertResponseFormat(response: HomeModel.FetchUserInfo.Response?)
    func passFailStatus()
}

protocol HomeNetworkingLogic {
    func startFetching(with request: HomeModel.FetchUserInfo.Request) async throws -> HomeModel.FetchUserInfo.Response
}


class HomeInteractor {

    var presenter: HomeInteractorOutput?
    let networkingWorker: HomeNetworkingLogic
    var response: HomeModel.FetchUserInfo.Response?

    init(presenter: HomeInteractorOutput, networkingWorker: HomeNetworkingLogic = HomeNetworkingWorker()) {
        self.presenter = presenter
        self.networkingWorker = networkingWorker
    }

}

extension HomeInteractor: HomeInteractorInput {

    func fetchUserInfo(request: HomeModel.FetchUserInfo.Request) {
        Task {
            do {
                self.response = try await self.networkingWorker.startFetching(with: request)
                self.presenter?.convertResponseFormat(response: self.response)

            } catch NetworkingError.invalidURL {
                print(NetworkingError.invalidURL)
                self.presenter?.passFailStatus()

            } catch NetworkingError.invalidResponse {
                print(NetworkingError.invalidResponse)
                self.presenter?.passFailStatus()

            } catch NetworkingError.invalidData {
                print(NetworkingError.invalidData)
                self.presenter?.passFailStatus()
            } catch {
                print("Unexpected error")
                self.presenter?.passFailStatus()
            }
        }
    }
}
