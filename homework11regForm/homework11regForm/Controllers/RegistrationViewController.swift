//
//  RegistrationViewController.swift
//  homework11regForm
//
//  Created by Mikhail Chuparnov on 21.01.2023.
//

import UIKit

final class RegistrationViewController: UIViewController, UITextFieldDelegate {
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Внесите свои данные"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 24, weight: .heavy)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let textFieldsStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.backgroundColor = .clear
        stack.contentMode = .scaleAspectFill
        stack.spacing = 16
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let firstNameTextField = TextField(placeholder: "Имя", keyboardType: .default)
    private let lastNameTextField = TextField(placeholder: "Фамилия", keyboardType: .default)
    private let mailTextField = TextField(placeholder: "Почта", keyboardType: .emailAddress)
    private let passwordTextField = TextField(placeholder: "Пароль", keyboardType: .default)
    
    private let createUserButton: UIButton = {
        let button = UIButton()
        button.clipsToBounds = true
        button.layer.cornerRadius = 12
        button.backgroundColor = .systemTeal
        button.setTitleColor(.white, for: .normal)
        button.setTitle("Cоздать аккаунт", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var textFieldsArray = [
        firstNameTextField,
        lastNameTextField,
        mailTextField,
        passwordTextField
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        setupProperts()
        registerForKeyboardNotifications()
        setupTapGesture()
    }
    
    private func setupLayout() {
        
        view.addSubview(titleLabel)
        view.addSubview(textFieldsStack)
        view.addSubview(createUserButton)
        
        textFieldsStack.addArrangedSubview(firstNameTextField)
        textFieldsStack.addArrangedSubview(lastNameTextField)
        textFieldsStack.addArrangedSubview(mailTextField)
        textFieldsStack.addArrangedSubview(passwordTextField)
        
        let inset:CGFloat = 16
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: inset),
            titleLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: inset),
            titleLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -inset),
        ])
        
        NSLayoutConstraint.activate([
            textFieldsStack.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: inset*2),
            textFieldsStack.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: inset),
            textFieldsStack.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -inset),
            textFieldsStack.heightAnchor.constraint(equalToConstant: CGFloat(48*4+16*3))
        ])
        
        NSLayoutConstraint.activate([
            createUserButton.topAnchor.constraint(equalTo: textFieldsStack.bottomAnchor, constant: inset*2),
            createUserButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: inset*2),
            createUserButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -inset*2),
            createUserButton.heightAnchor.constraint(equalToConstant: 56)
        ])
    }
    
    private func setupProperts() {
        view.backgroundColor = .systemGray6
        
        textFieldsArray.map {$0.delegate = self}
        
        createUserButton.addTarget(self, action: #selector(tapButton), for: .touchUpInside)
    }
    
    @objc private func tapButton() {
        createUserButton.animationTapButton()

        
        
        guard let firstName = firstNameTextField.text else {return}
        guard let lastName = lastNameTextField.text else {return}
        guard let mailText = mailTextField.text else {return}
        guard let password = passwordTextField.text else {return}
        
        if mailText == "test@mail.ru" {
            showAlreadyRegistredAlert(mail: mailText)
        } else {
            if firstName != "" && lastName != "" && mailText != "" && password != "" {
                let userModel = UserData(firstName: firstName, lastName: lastName, mail: mailText, password: password)
                let vc = ProfileViewController(user: userModel)
                self.navigationController?.setViewControllers([vc], animated: true)
            } else {
                textFieldsArray.map {$0.shakeTextFieldifEmpty()}
            }
        }
    }
    
    // MARK: - hide keyboard by tap in screen
    private func setupTapGesture() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    @objc func hideKeyboard() {
        self.view.endEditing(true)
    }
    
    // MARK: - keyboard notifications
    func registerForKeyboardNotifications() {
        NotificationCenter.default.addObserver(
            self,
            selector:#selector(keyboardWillShown),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        NotificationCenter.default.addObserver(
            self,
            selector:#selector(keyboardWillBeHidden),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }
    
    @objc func keyboardWillShown(_ notificiation: NSNotification) {
        self.view.frame.origin.y = -30
    }
    
    @objc func keyboardWillBeHidden(_ notificiation: NSNotification) {
        self.view.frame.origin.y = 0
    }
    
    // MARK: - Transition to next TextField by press Return
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        for i in 0...textFieldsArray.count - 1 {
            if textField == textFieldsArray[i] {
                if i != textFieldsArray.count - 1 {
                    textField.resignFirstResponder()
                    textFieldsArray[i+1].becomeFirstResponder()
                } else {
                    textField.resignFirstResponder()
                }
            }
        }
        return true
    }
    
    // MARK: - Alert if User already registred
    func showAlreadyRegistredAlert(mail: String) {
        let alert = UIAlertController(
            title: "Пользователь с такой почтой уже зарегистрирован",
            message: "Вы можете войти в свой профиль, используя эту почту",
            preferredStyle: UIAlertController.Style.alert
        )

        alert.addAction(UIAlertAction(
            title: "Понятно",
            style: UIAlertAction.Style.cancel)
        )
        
        // если пользователь с такой почтой существует, то по нажатии кнопки "Войти"
        // происходит переход на LoginViewController с введенной почтой в textfield mail
        
        alert.addAction(UIAlertAction(title: "Войти", style: .default, handler: { action in
            let vc = LoginViewController()
            vc.mailTextField.text = mail
            self.navigationController?.setViewControllers([vc], animated: true)
        }))
        
            self.present(alert, animated: true, completion: nil)
        }
    
}
