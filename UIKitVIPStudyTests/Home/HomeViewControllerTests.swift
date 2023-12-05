//
//  HomeViewControllerTests.swift
//  UIKitVIPStudyTests
//
//  Created by Marcelo de Araújo on 05/12/2023.
//

import XCTest
@testable import UIKitVIPStudy

final class HomeViewControllerTests: XCTestCase {

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
        let configurator = HomeConfigurator.shared
        let viewController = HomeViewController(configurator: configurator)
        
        // Then
        XCTAssertNotNil(viewController.router)
    }
    
    func testViewControllerShouldInitializeInteractor() {
        // Given
        let configurator = HomeConfigurator.shared
        let viewController = HomeViewController(configurator: configurator)
        
        // Then
        XCTAssertNotNil(viewController.interactor)
    }
    
    func testRouterShouldInitializeViewController() {
        // Given
        let configurator = HomeConfigurator.shared
        let viewController = HomeViewController(configurator: configurator)
        
        // Then
        XCTAssertEqual(viewController.router.viewController, viewController)
    }

    func testViewControllerShouldAskInteractorToFetchUserInfo() {
        // Given
        let mockInteractor = MockHomeInteractor()
        let configurator = HomeConfigurator.shared
        let viewController = HomeViewController(configurator: configurator)
        
        // When
        viewController.interactor = mockInteractor
        viewController.searchButtonTapped(input: "abc")
        
        // Then
        XCTAssertTrue(mockInteractor.isFetchUserInfoCalled)
    }

    func testViewControllerShouldAskRouterToNavigateToDetail() {
        // Given
        let dataToPass = UserInfo(
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
        let mockRouter = MockHomeRouter()
        let configurator = HomeConfigurator.shared
        let viewController = HomeViewController(configurator: configurator)
        
        // When
        viewController.router = mockRouter
        viewController.router.navigateToDetail(dataToPass: dataToPass, animated: true)
        
        // Then
        XCTAssertTrue(mockRouter.isNavigateToDetailCalled)
    }
}

final class MockHomeInteractor: HomeViewControllerOutput {
    var isFetchUserInfoCalled = false
    var response: HomeModel.FetchUserInfo.Response?

    func fetchUserInfo(request: HomeModel.FetchUserInfo.Request) {
        self.isFetchUserInfoCalled = true
    }
}

final class MockHomeRouter: HomeRoutingLogic {
    
    var isNavigateToDetailCalled = false
    var viewController: HomeViewController?

    func navigateToDetail(dataToPass: UserInfo, animated: Bool) {
        self.isNavigateToDetailCalled = true
    }
}
