//
//  DetailViewController.swift
//  UIKitVIPStudy
//
//  Created by Marcelo de Araújo on 05/12/2023.
//

import UIKit

typealias DetailViewControllerInput = DetailPresenterOutput

protocol DetailViewControllerOutput: AnyObject {
    func passUserInfoToPresenter(request: DetailModel.DisplayUserInfoDetails.Request)
}

protocol DetailRoutingLogic {
    var viewController: DetailViewController? { get }

    func navigateToGithub(userID: String)
}


final class DetailViewController: UIViewController {

    var dataToReceive: UserInfo
    private let detailView = DetailView()
    private var viewModel: DetailModel.DisplayUserInfoDetails.ViewModel?
    var router: DetailRoutingLogic!
    var interactor: DetailViewControllerOutput!

    init(dataToReceive: UserInfo, configurator: DetailConfigurator = DetailConfigurator.shared) {
        self.dataToReceive = dataToReceive
        super.init(nibName: nil, bundle: nil)
        configurator.configure(viewController: self)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension DetailViewController {

    override func loadView() {
        self.view = detailView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupView()
        self.dataReceivedFromPreviousScene()
    }

    private func setupView() {

        self.view.backgroundColor = .systemBackground
        self.navigationItem.title = "Mais Informações"
        self.detailView.delegate = self
        self.detailView.tableView.delegate = self
        self.detailView.tableView.dataSource = self
    }

    func dataReceivedFromPreviousScene() {
        let request = DetailModel.DisplayUserInfoDetails.Request(data: self.dataToReceive)
        self.interactor.passUserInfoToPresenter(request: request)
    }
}

extension DetailViewController: DetailViewControllerInput {

    func displayUserDetail(viewModel: DetailModel.DisplayUserInfoDetails.ViewModel) {
        self.viewModel = viewModel

        DispatchQueue.main.async {
            self.detailView.tableView.reloadData()
        }
    }
}

extension DetailViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel?.tableViewData.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: DetailTableViewCell.identifier, for: indexPath) as? DetailTableViewCell else { return UITableViewCell() }
        //cell.textLabel?.text = self.viewModel?.details[indexPath.row]
        cell.setupCellUI(
            title: self.viewModel?.tableViewData[indexPath.row].0 ?? "",
            description: self.viewModel?.tableViewData[indexPath.row].1 ?? ""
        )

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }

}

extension DetailViewController: DetailViewDelegate {
    func visitButtonTapped() {
        self.router.navigateToGithub(userID: self.dataToReceive.id)
    }
}
