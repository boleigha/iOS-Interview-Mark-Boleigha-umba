//
//  LoginViewController.swift
//  iOS Interview Mark Boleigha
//
//  Created by Mark Boleigha on 16/01/2022.
//

import UIKit
import WidgetUI
import Signals
import SwiftValidator

class LoginViewController: UIViewController {
    
    let validator = Validator()
    let viewModel = LoginViewModel()
    
    lazy var titleHeader: Text = {
        let font = Font.heading.make(withSize: 22)
        let txt = Text(font: font, content: "Login".attributed)
        txt.textColor = .white
        return txt
    }()

    lazy var username: TextInput = {
       let field = TextInput()
        field.placeholder = "Username"
        return field
    }()
    
    lazy var password: TextInput = {
        let field = TextInput()
        field.placeholder = "Password"
        field.isSecureTextEntry = true
        field.addViewPasswordButton()
        return field
    }()
    
    lazy var login: UIButton =  {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("Login", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.backgroundColor = Colors.crimson
        return btn
    }()
    
    lazy var guest: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("Continue as guest", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.backgroundColor = Colors.orange
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(hex: "FFFFFF").withAlphaComponent(0.9)
        
        self.view.addSubviews([titleHeader, username, password, login, guest])
        
        titleHeader.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: nil, bottom: nil, trailing: nil, padding: UIEdgeInsets(top: 30, left: 0, bottom: 0, right: 0))
        titleHeader.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        username.anchor(top: titleHeader.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: UIEdgeInsets(top: 80, left: 30, bottom: 0, right: 30))
        username.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        password.anchor(top: username.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: UIEdgeInsets(top: 23, left: 30, bottom: 0, right: 30))
        password.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        login.anchor(top: password.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: UIEdgeInsets(top: 23, left: 30, bottom: 0, right: 30))
        login.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        guest.anchor(top: login.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: UIEdgeInsets(top: 20, left: 30, bottom: 0, right: 30))
        guest.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        addActions()
    }
    
    private func addActions() {
        
        
        // Demo purpose only, password has to be at least eight characters or more
        validator.registerField(username, errorLabel: username.errorLabel, rules: [RequiredRule(), MinLengthRule(length: 4)])
        validator.registerField(password, errorLabel: password.errorLabel, rules: [RequiredRule(), MinLengthRule(length: 4)])
        
        
        login.onTouchUpInside.subscribe(with: self) {
            self.login.isEnabled = false
            self.validator.validate(self)
        }.onQueue(.main)
        
        
        guest.onTouchUpInside.subscribe(with: self) {
            self.login.isEnabled = false
            self.loading.showOverlay(view: self.view)
            self.loginGuest()
        }
    }
    
    func loginGuest() {
        viewModel.login_guest() { (token) in
            self.loading.hideOverlayView()
            if token == true {
                Navigation.setUpAsRootViewController()
            } else {
                self.showAlert(type: .error, message: "Unable to authenticate, please retry")
            }
        }
    }
}

extension LoginViewController: ValidationDelegate {
    func validationSuccessful() {
        self.showAlert(type: .ok, message: "login click")
    }
    
    func validationFailed(_ errors: [(Validatable, ValidationError)]) {
        for (field, error) in errors {
            guard let field = field as? TextInput else {
                DispatchQueue.main.async {
                    self.showAlert(type: .error, message: error.errorMessage)
                }
                return
            }
            field.errorLabel.isHidden = false
            field.errorLabel.text = error.errorMessage
        }
        login.isEnabled = true
    }
}


