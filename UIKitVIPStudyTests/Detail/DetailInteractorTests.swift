//
//  DetailInteractorTests.swift
//  UIKitVIPStudyTests
//
//  Created by Marcelo de Araújo on 05/12/2023.
//

import XCTest
@testable import UIKitVIPStudy

final class DetailInteractorTests: XCTestCase {

    override func setUpWithError() throws {
        try super.setUpWithError()
    }
    
    override func tearDownWithError() throws {
        try super.tearDownWithError()
    }

    func testInteractorShouldAskPresenterToConvertResponseFormat() {
        // Given
        let data = UserInfo(
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
        let request = DetailModel.DisplayUserInfoDetails.Request.init(data: data)
        let mockPresenter = MockDetailPresenter()
        let interactor = DetailInteractor(presenter: mockPresenter)
        
        // When
        interactor.passUserInfoToPresenter(request: request)
        
        // Then
        XCTAssertTrue(mockPresenter.isConvertResponseFormatCalled)
    }
}

final class MockDetailPresenter: DetailInteractorOutput {
    
    var isConvertResponseFormatCalled = false
    
    func convertResponseFormat(userInfoDetails: UserInfo?) {
        self.isConvertResponseFormatCalled = true
    }
}
