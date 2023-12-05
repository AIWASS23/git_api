//
//  DetailViewControllerTests.swift
//  UIKitVIPStudyTests
//
//  Created by Marcelo de Araújo on 05/12/2023.
//

import XCTest
@testable import UIKitVIPStudy

final class DetailViewControllerTests: XCTestCase {
    
    private var window: UIWindow!

    override func setUpWithError() throws {
        try super.setUpWithError()
        
        self.window = UIWindow()
    }
    
    override func tearDownWithError() throws {
        try super.tearDownWithError()
        
        self.window = nil
    }
    
    func testViewControllerShouldInitializeRouter() {
        // Given
        let dataToReceive = UserInfo(
            imageURL: "https://avatars.githubusercontent.com/u/84019436?s=400&u=38820439e2c5ef8fc4500756695cd7b303877be0&v=4",
            id: "AIWASS23",
            name: "Marcelo de Araújo",
            bio: "Se não sabemos mais rir, então somente nos resta chorar.",
            location: "Fortaleza -CE",
            publicRepositories: 46,
            publicGists: 0,
            followers: 22,
            following: 7
        )
        let configurator = DetailConfigurator.shared
        let viewController = DetailViewController(
            dataToReceive: dataToReceive, 
            configurator: configurator
        )
        
        // Then
        XCTAssertNotNil(viewController.router)
    }
    
    func testViewControllerShouldInitializeInteractor() {
        // Given
        let dataToReceive = UserInfo(
            imageURL: "https://avatars.githubusercontent.com/u/84019436?s=400&u=38820439e2c5ef8fc4500756695cd7b303877be0&v=4",
            id: "AIWASS23",
            name: "Marcelo de Araújo",
            bio: "Se não sabemos mais rir, então somente nos resta chorar.",
            location: "Fortaleza -CE",
            publicRepositories: 46,
            publicGists: 0,
            followers: 22,
            following: 7
        )
        let configurator = DetailConfigurator.shared
        let viewController = DetailViewController(
            dataToReceive: dataToReceive,
            configurator: configurator
        )
        
        // Then
        XCTAssertNotNil(viewController.interactor)
    }
    
    func testRouterShouldInitializeViewController() {
        // Given
        let dataToReceive = UserInfo(
            imageURL: "https://avatars.githubusercontent.com/u/84019436?s=400&u=38820439e2c5ef8fc4500756695cd7b303877be0&v=4",
            id: "AIWASS23",
            name: "Marcelo de Araújo",
            bio: "Se não sabemos mais rir, então somente nos resta chorar.",
            location: "Fortaleza -CE",
            publicRepositories: 46,
            publicGists: 0,
            followers: 22,
            following: 7
        )
        let configurator = DetailConfigurator.shared
        let viewController = DetailViewController(
            dataToReceive: dataToReceive,
            configurator: configurator
        )
        
        // Then
        XCTAssertEqual(viewController.router.viewController, viewController)
    }

    func testViewControllerShouldAskInteractorToPassUserInfoToPresenter() {
        // Given
        let dataToReceive = UserInfo(
            imageURL: "https://avatars.githubusercontent.com/u/84019436?s=400&u=38820439e2c5ef8fc4500756695cd7b303877be0&v=4",
            id: "AIWASS23",
            name: "Marcelo de Araújo",
            bio: "Se não sabemos mais rir, então somente nos resta chorar.",
            location: "Fortaleza -CE",
            publicRepositories: 46,
            publicGists: 0,
            followers: 22,
            following: 7
        )
        let mockInteractor = MockDetailInteractor()
        let configurator = DetailConfigurator.shared
        let viewController = DetailViewController(
            dataToReceive: dataToReceive,
            configurator: configurator
        )
        
        // When
        viewController.interactor = mockInteractor
        viewController.dataReceivedFromPreviousScene()
        
        // Then
        XCTAssertTrue(mockInteractor.isPassUserInfoToPresenterCalled)
    }

    func testViewControllerShouldAskRouterToNavigateToGithub() {
        // Given
        let dataToReceive = UserInfo(
            imageURL: "https://avatars.githubusercontent.com/u/84019436?s=400&u=38820439e2c5ef8fc4500756695cd7b303877be0&v=4",
            id: "AIWASS23",
            name: "Marcelo de Araújo",
            bio: "Se não sabemos mais rir, então somente nos resta chorar.",
            location: "Fortaleza -CE",
            publicRepositories: 46,
            publicGists: 0,
            followers: 22,
            following: 7
        )
        let mockRouter = MockDetailRouter()
        let configurator = DetailConfigurator.shared
        let viewController = DetailViewController(
            dataToReceive: dataToReceive,
            configurator: configurator
        )
        
        // When
        viewController.router = mockRouter
        viewController.visitButtonTapped()
        
        // Then
        XCTAssertTrue(mockRouter.isNavigateToGithubCalled)
    }
    
}


final class MockDetailInteractor: DetailViewControllerOutput {
    
    var isPassUserInfoToPresenterCalled = false
    
    func passUserInfoToPresenter(request: DetailModel.DisplayUserInfoDetails.Request) {
        self.isPassUserInfoToPresenterCalled = true
    }
}

final class MockDetailRouter: DetailRoutingLogic {
    
    var isNavigateToGithubCalled = false
    
    var viewController: DetailViewController?
    
    func navigateToGithub(userID: String) {
        self.isNavigateToGithubCalled = true
    }
}
