//
//  HomePresenterTests.swift
//  UIKitVIPStudyTests
//
//  Created by Marcelo de Araújo on 05/12/2023.
//

import XCTest
@testable import UIKitVIPStudy

final class HomePresenterTests: XCTestCase {

    override func setUpWithError() throws {
        try super.setUpWithError()
    }
    
    override func tearDownWithError() throws {
        try super.tearDownWithError()
    }

    func testPresenterShouldAskViewControllerTodisplayUserProfile() {
        // Given
        let response = HomeModel.FetchUserInfo.Response(
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
        let mockViewController = MockHomeViewController()
        let presenter = HomePresenter(viewController: mockViewController)
        
        // When
        presenter.convertResponseFormat(response: response)
        
        // Then
        XCTAssertTrue(mockViewController.isDisplayUserProfileCalled)
    }

    func testPresenterShouldAskViewControllerToprepareDataToPass() {
        // Given
        let response = HomeModel.FetchUserInfo.Response(
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
        let mockViewController = MockHomeViewController()
        let presenter = HomePresenter(viewController: mockViewController)
        
        // When
        presenter.convertResponseFormat(response: response)
        
        // Then
        XCTAssertTrue(mockViewController.isPrepareDataToPassCalled)
    }

    func testPresenterShouldAskViewControllerToDisplayFailStatus() {
        // Given
        let mockViewController = MockHomeViewController()
        let presenter = HomePresenter(viewController: mockViewController)
        
        // When
        presenter.passFailStatus()
        
        // Then
        XCTAssertTrue(mockViewController.isDisplayFailStatusCalled)
    }
}

final class MockHomeViewController: HomePresenterOutput {
    
    var isDisplayUserProfileCalled = false
    var isDisplayFailStatusCalled = false
    var isPrepareDataToPassCalled = false
    
    func displayUserProfile(viewModel: HomeModel.FetchUserInfo.ViewModel) {
        self.isDisplayUserProfileCalled = true
    }
    
    func displayFailStatus() {
        self.isDisplayFailStatusCalled = true
    }
    
    func prepareDataToPass(dataToPass: UserInfo) {
        self.isPrepareDataToPassCalled = true
    }
}
