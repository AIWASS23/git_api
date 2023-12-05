//
//  HomeInteractorTests.swift
//  HomeInteractorTests
//
//  Created by Marcelo de Araújo on 05/12/2023.
//

import XCTest
@testable import UIKitVIPStudy

final class HomeInteractorTests: XCTestCase {
    
    override func setUpWithError() throws {
        try super.setUpWithError()
    }
    
    override func tearDownWithError() throws {
        try super.tearDownWithError()
    }

    func testInteractorShouldAskNetworkingWorkerToFetchUserInfo() {
        // Given
        let request = HomeModel.FetchUserInfo.Request.init(id: "MockID")
        let mockNetworkingWorker = MockHomeNetworkingWorker()
        let mockPresenter = MockHomePresenter()
        let interactor = HomeInteractor(
            presenter: mockPresenter,
            networkingWorker: mockNetworkingWorker
        )

        DispatchQueue.main.async {
            // When
            interactor.fetchUserInfo(request: request)
        
            // Then
            XCTAssertTrue(mockNetworkingWorker.isFetchingSuccessful)
        }
    }

    func testInteractorShouldAskPresenterToConvertResponseFormat() {
        // Given
        let request = HomeModel.FetchUserInfo.Request.init(id: "MockID")
        let mockNetworkingWorker = MockHomeNetworkingWorker()
        let mockPresenter = MockHomePresenter()
        let interactor = HomeInteractor(
            presenter: mockPresenter,
            networkingWorker: mockNetworkingWorker
        )

        DispatchQueue.main.async {
            // When
            interactor.fetchUserInfo(request: request)
            
            // Then
            XCTAssertTrue(mockPresenter.isConvertResponseFormatCalled)
            XCTAssertFalse(mockPresenter.isPassFailStatusCalled)
        }
    }
    

    func testInteractorShouldAskPresenterToPassFailStatus() {
        // Given
        let request = HomeModel.FetchUserInfo.Request.init(id: "MockID")
        let mockNetworkingWorker = MockHomeNetworkingWorker()
        let mockPresenter = MockHomePresenter()
        let interactor = HomeInteractor(
            presenter: mockPresenter,
            networkingWorker: mockNetworkingWorker
        )

        DispatchQueue.main.async {
            // When
            mockNetworkingWorker.isFetchingFailed = true
            interactor.fetchUserInfo(request: request)
            
            // Then
            XCTAssertTrue(mockPresenter.isPassFailStatusCalled)
            XCTAssertFalse(mockPresenter.isConvertResponseFormatCalled)
        }
    }
}

final class MockHomeNetworkingWorker: HomeNetworkingLogic {
    
    var isFetchingSuccessful = false
    var isFetchingFailed = false
    
    enum FetchError: Error {
        case someError
    }

    func startFetching(with request: HomeModel.FetchUserInfo.Request) async throws -> HomeModel.FetchUserInfo.Response {
        self.isFetchingSuccessful = true
        if self.isFetchingFailed {
            throw FetchError.someError
        } else {
            return HomeModel.FetchUserInfo.Response.init(
                avatarUrl: "https://avatars.githubusercontent.com/u/84019436?s=400&u=38820439e2c5ef8fc4500756695cd7b303877be0&v=4",
                login: "AIWASS23",
                name: "Marcelo de Araújo",
                bio: "Se não sabemos mais rir, então somente nos resta chorar.",
                location: "Fortaleza -CE",
                publicRepos: 46,
                publicGists: 0,
                followers: 22,
                following: 7
            )
        }
    }
}

final class MockHomePresenter: HomeInteractorOutput {

    var isConvertResponseFormatCalled = false
    var isPassFailStatusCalled = false

    func convertResponseFormat(response: HomeModel.FetchUserInfo.Response?) {
        self.isConvertResponseFormatCalled = true
    }

    func passFailStatus() {
        self.isPassFailStatusCalled = true
    }
}
