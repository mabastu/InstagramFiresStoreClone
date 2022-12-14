//
//  RegistrationController.swift
//  InstagramFiresStoreClone
//
//  Created by Mabast on 11/7/22.
//

import UIKit

class RegistrationController: UIViewController {
    
    // MARK: - Properties
    
    var viewModel = ViewModel()
    private var profileImage: UIImage?
    weak var delegate: AuthenticationDelegate?
    
    private lazy var addProfilePhotoButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "plus_photo"), for: .normal)
        button.addTarget(self, action: #selector(selectProfilePhoto), for: .touchUpInside)
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
 
    private lazy var signupButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Sign Up", for: .normal)
        button.setTitleColor(.white.withAlphaComponent(0.5), for: .normal)
        button.backgroundColor = .systemPurple.withAlphaComponent(0.5)
        button.layer.cornerRadius = 5
        button.setHeight(50)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.addTarget(self, action: #selector(signUpRegistration), for: .touchUpInside)
        return button
    }()
    
    private lazy var alreadyHaveAnAccountButton: UIButton = {
        let button = UIButton(type: .system)
        button.attributedTitle(regularText: "Already have an account? ", boldText: "Log in.")
        button.addTarget(self, action: #selector(navigateToLoginView), for: .touchUpInside)
        return button
    }()
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureNotificationObservers()
    }
    
    // MARK: - Actions
    
    @objc func navigateToLoginView() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func textFieldsDidChanged(sender: UITextField) {
        if sender == emailTextField {
            viewModel.email = sender.text
        } else if sender == passwordTextField {
            viewModel.password = sender.text
        } else if sender == fullNameTextField {
            viewModel.fullname = sender.text
        } else {
            viewModel.username = sender.text
        }
        updateFormUI(sender: signupButton, isEnabled: viewModel.signupFormIsValid)
    }
    
    @objc func selectProfilePhoto() {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        
        present(imagePicker, animated: true)
    }
    
    @objc func signUpRegistration() {
        guard let email = emailTextField.text else { return }
        guard let password = passwordTextField.text else { return }
        guard let fullname = fullNameTextField.text else { return }
        guard let username = usernameTextField.text?.lowercased() else { return }
        guard let profileImage = self.profileImage else { return }
        
        let credentials = AuthenticationCredentials(email: email, password: password, fullname: fullname, username: username, profileImage: profileImage)
        AuthenticationService.registerUser(withCredentilas: credentials) { error in
            if let error = error {
                print("Failed to register user \(error.localizedDescription)")
                return
            }
            
            self.delegate?.authenticationDidComplete()
        }
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
    
    func configureNotificationObservers() {
        emailTextField.addTarget(self, action: #selector(textFieldsDidChanged), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(textFieldsDidChanged), for: .editingChanged)
        fullNameTextField.addTarget(self, action: #selector(textFieldsDidChanged), for: .editingChanged)
        usernameTextField.addTarget(self, action: #selector(textFieldsDidChanged), for: .editingChanged)
    }
}

// MARK: - UIImagePickerControllerDelegate

extension RegistrationController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        guard let selectedImage = info[.editedImage] as? UIImage else { return }
        profileImage = selectedImage
        
        addProfilePhotoButton.layer.cornerRadius = addProfilePhotoButton.frame.width / 2
        addProfilePhotoButton.layer.masksToBounds = true
        addProfilePhotoButton.layer.borderColor = UIColor.white.cgColor
        addProfilePhotoButton.layer.borderWidth = 2
        addProfilePhotoButton.setImage(selectedImage.withRenderingMode(.alwaysOriginal), for: .normal)
        
        self.dismiss(animated: true)
    }
}
