//
//  ProfileViewController.swift
//  homework11regForm
//
//  Created by Mikhail Chuparnov on 23.01.2023.
//

import UIKit

final class ProfileViewController: UIViewController {

    private var userData: UserData?
    
    private let labelStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .equalSpacing
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let firstLabel = Label(ofSize: 18, weight: .light)
    
    private let lastLabel = Label(ofSize: 18, weight: .light)
    
    private let mailLabel = Label(ofSize: 18, weight: .light)
    
    private let passLabel = Label(ofSize: 18, weight: .light)
    
    private let titleStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .equalSpacing
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let firstTitleLabel = Label(ofSize: 18, weight: .regular)
    
    private let lastTitleLabel = Label(ofSize: 18, weight: .regular)
    
    private let mailTitleLabel = Label(ofSize: 18, weight: .regular)
    
    private let passTitleLabel = Label(ofSize: 18, weight: .regular)
    
    private let exitButton: UIButton = {
        let button = UIButton()
        button.clipsToBounds = true
        button.layer.cornerRadius = 12
        button.backgroundColor = .systemTeal
        button.setTitleColor(.white, for: .normal)
        button.setTitle("Выйти", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    init(user: UserData) {
        self.userData = user
        super.init(nibName: nil, bundle: nil)
        setupData(user: user)
    }
    
    @available (*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupProperts()
        setupLayout()
    }
    
    private func setupLayout() {
        view.addSubview(labelStack)
        view.addSubview(titleStack)
        view.addSubview(exitButton)
        
        labelStack.addArrangedSubview(firstLabel)
        labelStack.addArrangedSubview(lastLabel)
        labelStack.addArrangedSubview(mailLabel)
        labelStack.addArrangedSubview(passLabel)
        
        titleStack.addArrangedSubview(firstTitleLabel)
        titleStack.addArrangedSubview(lastTitleLabel)
        titleStack.addArrangedSubview(mailTitleLabel)
        titleStack.addArrangedSubview(passTitleLabel)
        
        let inset:CGFloat = 16
        
        NSLayoutConstraint.activate([
            titleStack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: inset*2),
            titleStack.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: inset),
            titleStack.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.3),
            titleStack.heightAnchor.constraint(equalToConstant: CGFloat(120))
        ])
        
        NSLayoutConstraint.activate([
            labelStack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: inset*2),
            labelStack.leadingAnchor.constraint(equalTo: titleStack.trailingAnchor),
            labelStack.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -inset),
            labelStack.heightAnchor.constraint(equalToConstant: CGFloat(120))
        ])
        
        NSLayoutConstraint.activate([
            exitButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -inset*2),
            exitButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: inset*2),
            exitButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -inset*2),
            exitButton.heightAnchor.constraint(equalToConstant: 56)
        ])

    }
    
    private func setupProperts() {
        view.backgroundColor = .systemGray6
        
        firstTitleLabel.text = "Имя"
        lastTitleLabel.text = "Фамилия"
        mailTitleLabel.text = "Почта"
        passTitleLabel.text = "Пароль"
        
        exitButton.addTarget(self, action: #selector(tapButton), for: .touchUpInside)
        
    }
    
    private func setupData(user: UserData) {
        firstLabel.setupData(text: user.firstName)
        lastLabel.setupData(text: user.lastName)
        mailLabel.setupData(text: user.mail)
        passLabel.setupData(text: user.password)
    }

    @objc private func tapButton() {
        let vc = LoginViewController()
        navigationController?.setViewControllers([vc], animated: true)
    }
}
