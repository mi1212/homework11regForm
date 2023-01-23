//
//  LoginViewController.swift
//  UINavigationViewController
//
//  Created by Mikhail Chuparnov on 16.01.2023.
//

import UIKit

final class LoginViewController: UIViewController {
    
    private let iconImageView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "boris")
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private let textFieldsStack: UIStackView = {
        let stack = UIStackView()
        stack.spacing = 16
        stack.axis = .vertical
        stack.distribution = .fillEqually
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let loginButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 12
        button.clipsToBounds = true
        button.setTitle("login", for: .normal)
        button.backgroundColor = .systemTeal
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let createUserButton: UIButton = {
        let button = UIButton()
        button.clipsToBounds = true
        button.setTitle("create user", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let mailTextField = TextField(placeholder: "mail", keyboardType: .emailAddress)
    
    private let passTextField = TextField(placeholder: "password", keyboardType: .default)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemGray5
        setupLayout()
        setupTapDissmisedKeyboard()
    }
    
    private func setupLayout() {
        self.view.addSubview(textFieldsStack)
        self.view.addSubview(iconImageView)
        self.view.addSubview(loginButton)
        self.view.addSubview(createUserButton)
        
        textFieldsStack.addArrangedSubview(mailTextField)
        textFieldsStack.addArrangedSubview(passTextField)
        
        loginButton.addTarget(self, action: #selector(tapButton), for: .touchUpInside)
        createUserButton.addTarget(self, action: #selector(tapCreateUserButton), for: .touchUpInside)
        
        let inset: CGFloat = 16
        
        NSLayoutConstraint.activate([
            textFieldsStack.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            textFieldsStack.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: inset),
            textFieldsStack.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -inset),
            textFieldsStack.heightAnchor.constraint(equalToConstant: 112),
        ])
        
        NSLayoutConstraint.activate([
            iconImageView.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.2),
            iconImageView.widthAnchor.constraint(equalTo: iconImageView.heightAnchor),
            iconImageView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            iconImageView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: inset*3)
        ])
        
        NSLayoutConstraint.activate([
            loginButton.topAnchor.constraint(equalTo: textFieldsStack.bottomAnchor, constant: inset*3),
            loginButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: inset*2),
            loginButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -inset*2),
            loginButton.heightAnchor.constraint(equalToConstant: 56),
        ])
        
        NSLayoutConstraint.activate([
            createUserButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -inset*2),
            createUserButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            createUserButton.heightAnchor.constraint(equalToConstant: 56),
        ])
    }
    
    @objc private func tapButton() {
        loginButton.animationTapButton()
        passTextField.shakeTextFieldifEmpty()
        mailTextField.shakeTextFieldifEmpty()
        guard let pass = passTextField.text else {return}
        guard let mail = mailTextField.text else {return}
        if pass == "123456" && mail == "test@mail.ru" {
            let user = UserData(firstName: "test Name", lastName: "test LastName", mail: mail, password: pass)
            let vc = ProfileViewController(user: user)
            self.navigationController?.setViewControllers([vc], animated: true)
        }
    }
    
    @objc private func tapCreateUserButton() {
        let vc = RegistrationViewController()
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    private func setupTapDissmisedKeyboard() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

