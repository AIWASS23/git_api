//
//  DetailView.swift
//  UIKitVIPStudy
//
//  Created by Marcelo de Araújo on 05/12/2023.
//

import UIKit

protocol DetailViewDelegate: AnyObject {
    func visitButtonTapped()
}

class DetailView: UIView {

    private lazy var visitButton: UIButton = {
        let button = UIButton(type: .custom)
        button.backgroundColor = .systemBackground
        button.setImage(UIImage(named: "github-mark"), for: .normal)
        button.layer.cornerRadius = 50
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(self.buttonTapped(_:)), for: .touchUpInside)
        return button
    }()

    let tableView: UITableView = {
        let tv = UITableView()
        tv.register(DetailTableViewCell.self, forCellReuseIdentifier: DetailTableViewCell.identifier)
        tv.showsVerticalScrollIndicator = true
        tv.separatorStyle = .singleLine
        tv.allowsSelection = false
        return tv
    }()

    weak var delegate: DetailViewDelegate?

    override init(frame: CGRect) {
        super.init(frame: frame)

        self.setupSubview()
        self.setupAutoLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


extension DetailView {

    private func setupSubview() {
        self.addSubview(self.visitButton)
        self.addSubview(self.tableView)
    }

    private func setupAutoLayout() {
        self.visitButton.translatesAutoresizingMaskIntoConstraints = false
        self.tableView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            self.visitButton.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 25),
            self.visitButton.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            self.visitButton.widthAnchor.constraint(equalToConstant: 100),
            self.visitButton.heightAnchor.constraint(equalToConstant: 100),

            self.tableView.topAnchor.constraint(equalTo: self.visitButton.bottomAnchor, constant: 25),
            self.tableView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor),
            self.tableView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            self.tableView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor),
        ])
    }

    @objc private func buttonTapped(_ button: UIButton) {
        self.delegate?.visitButtonTapped()

    }
}
