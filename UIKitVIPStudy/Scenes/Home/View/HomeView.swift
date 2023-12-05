//
//  HomeView.swift
//  UIKitVIPStudy
//
//  Created by Marcelo de Araújo on 05/12/2023.
//

import UIKit

protocol HomeViewDelegate: AnyObject {
    func searchButtonTapped(input: String)
    func seeDetailsButtonTapped()
}

class HomeView: UIView {
    
    let idTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Insira o ID do Github"
        tf.borderStyle = .roundedRect
        tf.autocorrectionType = .no
        tf.autocapitalizationType = .none
        tf.returnKeyType = .done
        tf.clearButtonMode = .whileEditing
        return tf
    }()
    
    private lazy var searchButton: UIButton = {
        let button = UIButton(type: .custom)
        button.backgroundColor = .tintColor
        button.setTitle("Pesquisar", for: .normal)
        button.layer.cornerRadius = 5
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(self.buttonTapped(_:)), for: .touchUpInside)
        return button
    }()
    
    private lazy var searchStackView: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [self.idTextField, self.searchButton])
        sv.axis = .horizontal
        sv.alignment = .center
        sv.distribution = .fill
        sv.spacing = 10
        return sv
    }()
    
    private let userProfileImage: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage()
        iv.contentMode = .scaleToFill
        iv.layer.borderColor = UIColor.label.cgColor
        iv.layer.borderWidth = 2
        iv.layer.cornerRadius = 75
        iv.clipsToBounds = true
        return iv
    }()
    
    private let userProfileName: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.text = "?"
        return label
    }()
    
    private lazy var seeDetailsButton: UIButton = {
        let button = UIButton(type: .custom)
        button.isEnabled = false
        button.backgroundColor = .systemGray5
        button.setTitle("Veja Detalhes", for: .normal)
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(self.buttonTapped(_:)), for: .touchUpInside)
        return button
    }()
    
    weak var delegate: HomeViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setupSubview()
        self.setupAutoLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension HomeView {
    
    private func setupSubview() {
        self.addSubview(self.searchStackView)
        self.addSubview(self.userProfileImage)
        self.addSubview(self.userProfileName)
        self.addSubview(self.seeDetailsButton)
    }
    
    private func setupAutoLayout() {
        self.searchStackView.translatesAutoresizingMaskIntoConstraints = false
        self.userProfileImage.translatesAutoresizingMaskIntoConstraints = false
        self.userProfileName.translatesAutoresizingMaskIntoConstraints = false
        self.seeDetailsButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.searchStackView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 10),
            self.searchStackView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            self.searchStackView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            
            self.searchButton.widthAnchor.constraint(equalToConstant: 50),
            
            self.userProfileImage.topAnchor.constraint(equalTo: self.searchStackView.bottomAnchor, constant: 50),
            self.userProfileImage.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            self.userProfileImage.widthAnchor.constraint(equalToConstant: 150),
            self.userProfileImage.heightAnchor.constraint(equalToConstant: 150),
            
            self.userProfileName.topAnchor.constraint(equalTo: self.userProfileImage.bottomAnchor, constant: 10),
            self.userProfileName.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            self.userProfileName.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            
            self.seeDetailsButton.topAnchor.constraint(equalTo: self.userProfileName.bottomAnchor, constant: 50),
            self.seeDetailsButton.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            self.seeDetailsButton.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            self.seeDetailsButton.heightAnchor.constraint(equalToConstant: 50),
        ])
    }
    
    @objc private func buttonTapped(_ button: UIButton) {
        if button == self.searchButton {
            self.delegate?.searchButtonTapped(input: self.idTextField.text ?? "")
        }
        
        if button == self.seeDetailsButton {
            self.delegate?.seeDetailsButtonTapped()
        }
    }
    
}

extension HomeView {

    func setupView(imageURL: String, name: String) {
        self.userProfileImage.load(url: imageURL)
        
        DispatchQueue.main.async {
            self.userProfileName.text = name
            self.seeDetailsButton.isEnabled = true
            self.seeDetailsButton.backgroundColor = .tintColor
        }
    }
    
    func setupView() {
        DispatchQueue.main.async {
            self.userProfileImage.image = UIImage(systemName: "xmark")
            self.userProfileImage.tintColor = .red
            self.userProfileName.text = "Usuário não encontrado"
        }
    }
}
