//
//  RegistrationController.swift
//  InstagramFiresStoreClone
//
//  Created by Mabast on 11/7/22.
//

import UIKit

class RegistrationController: UIViewController {
    
    // MARK: - Properties
    
    private let addProfilePhotoButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "plus_photo"), for: .normal)
        button.tintColor = .white
        return button
    }()
    
    private let emailTextField: UITextField = {
        let textField = CustomTextField(placeholder: "Email")
        textField.keyboardType = .emailAddress
        return textField
    }()
    
    private let passwordTextField: UITextField = {
        let textField = CustomTextField(placeholder: "Password")
        textField.isSecureTextEntry = true
        return textField
    }()
    
    private let fullNameTextField = CustomTextField(placeholder: "Full Name")
    private let usernameTextField = CustomTextField(placeholder: "Username")
 
    private let signupButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Sign Up", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemPurple.withAlphaComponent(0.5)
        button.layer.cornerRadius = 5
        button.setHeight(50)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        return button
    }()
    
    private lazy var alreadyHaveAnAccountButton: UIButton = {
        let button = UIButton(type: .system)
        button.attributedTitle(regularText: "Already have an account? ", boldText: "Login.")
        button.addTarget(self, action: #selector(navigateToLoginView), for: .touchUpInside)
        return button
    }()
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    // MARK: - Actions
    
    @objc func navigateToLoginView() {
        navigationController?.popViewController(animated: true)
    }
    
    // MARK: - Helpers
    
    func configureUI() {
        configureGradientLayer()
        
        view.addSubview(addProfilePhotoButton)
        addProfilePhotoButton.centerX(inView: view)
        addProfilePhotoButton.setDimensions(height: 140, width: 140)
        addProfilePhotoButton.anchor(top: view.safeAreaLayoutGuide.topAnchor, paddingTop: 32)
        
        let stackView = UIStackView(arrangedSubviews: [emailTextField, passwordTextField, fullNameTextField, usernameTextField, signupButton])
        stackView.axis = .vertical
        stackView.spacing = 20
        view.addSubview(stackView)
        stackView.anchor(top: addProfilePhotoButton.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 32, paddingLeft: 32, paddingRight: 32)
        
        view.addSubview(alreadyHaveAnAccountButton)
        alreadyHaveAnAccountButton.centerX(inView: view)
        alreadyHaveAnAccountButton.anchor(bottom: view.safeAreaLayoutGuide.bottomAnchor)
    }
}
