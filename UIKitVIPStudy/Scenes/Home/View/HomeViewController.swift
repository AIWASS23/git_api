//
//  ListViewController.swift
//  UIKitVIPStudy
//
//  Created by Marcelo de Araújo on 05/12/2023.
//

import UIKit

typealias HomeViewControllerInput = HomePresenterOutput

protocol HomeViewControllerOutput: AnyObject {
    var response: HomeModel.FetchUserInfo.Response? { get }

    func fetchUserInfo(request: HomeModel.FetchUserInfo.Request)
}

protocol HomeRoutingLogic {
    var viewController: HomeViewController? { get }

    func navigateToDetail(dataToPass: UserInfo, animated: Bool)
}

class HomeViewController: UIViewController {

    var dataToPass: UserInfo!
    private let homeView = HomeView()
    private var viewModel: HomeModel.FetchUserInfo.ViewModel?
    var router: HomeRoutingLogic!
    var interactor: HomeViewControllerOutput!

    init(configurator: HomeConfigurator = HomeConfigurator.shared) {
        super.init(nibName: nil, bundle: nil)

        configurator.configure(viewController: self)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}


extension HomeViewController {

    override func loadView() {
        self.view = homeView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupView()
    }

    private func setupView() {
        self.view.backgroundColor = .systemBackground
        self.navigationItem.title = "Pesquisar"
        self.homeView.delegate = self
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.homeView.idTextField.endEditing(true)
    }

}


extension HomeViewController: HomeViewControllerInput {

    func displayUserProfile(viewModel: HomeModel.FetchUserInfo.ViewModel) {
        self.homeView.setupView(imageURL: viewModel.imageURL, name: viewModel.id)
    }

    func displayFailStatus() {
        self.homeView.setupView()
    }

    func prepareDataToPass(dataToPass: UserInfo) {
        self.dataToPass = dataToPass
    }

}


extension HomeViewController: HomeViewDelegate {

    func searchButtonTapped(input: String) {
        let request = HomeModel.FetchUserInfo.Request(id: input)
        self.interactor.fetchUserInfo(request: request)

        self.homeView.idTextField.text = ""
        self.homeView.idTextField.resignFirstResponder()
    }

    func seeDetailsButtonTapped() {
        self.router.navigateToDetail(dataToPass: self.dataToPass, animated: true)
    }

}
