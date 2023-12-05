//
//  DetailTableViewCell.swift
//  UIKitVIPStudy
//
//  Created by Marcelo de Araújo on 05/12/2023.
//

import UIKit

class DetailTableViewCell: UITableViewCell {

    static let identifier = "DetailTableViewCell"

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.textAlignment = .left
        label.numberOfLines = 1
        return label
    }()

    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.textAlignment = .left
        label.numberOfLines = 2
        return label
    }()

    private lazy var accountStackView: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [self.titleLabel, self.descriptionLabel])
        sv.axis = .horizontal
        sv.alignment = .center
        sv.distribution = .equalSpacing
        sv.spacing = 20
        return sv
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)

        self.addSubview()
        self.setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


extension DetailTableViewCell {
    
    private func addSubview() {
        self.contentView.addSubview(self.accountStackView)
    }

    private func setupLayout() {
        self.accountStackView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            self.accountStackView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 10),
            self.accountStackView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -10),
            self.accountStackView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 15),
            self.accountStackView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -15),
            //self.accountStackView.centerYAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerYAnchor)
        ])
    }
}

extension DetailTableViewCell {

    func setupCellUI(title: String, description: String) {
        self.titleLabel.text = title
        self.descriptionLabel.text = description
    }
}
