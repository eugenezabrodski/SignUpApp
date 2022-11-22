//
//  SignUpViewController.swift
//  SignUpApp
//
//  Created by Евгений Забродский on 17.11.22.
//

import UIKit

final class SignUpViewController: UIViewController {

    // MARK: - IBOutlets
    
    @IBOutlet private weak var emailTF: UITextField!
    
    @IBOutlet private weak var errorEmail: UILabel!
    
    @IBOutlet private weak var nameTF: UITextField!
    
    @IBOutlet private weak var passwordTF: UITextField!
    
    @IBOutlet private weak var errorPassword: UILabel!
    
    @IBOutlet private var strongPasswordIndicator: [UIView]!
    
    @IBOutlet private weak var confirmPasswordTF: UITextField!
    
    @IBOutlet private weak var errorConfirmPass: UILabel!
    
    @IBOutlet private weak var continueButton: UIButton!
    
    @IBOutlet private weak var scrollView: UIScrollView!
    
    //MARK: - Properties
    
    private var isValidEmail = false { didSet {updateButtonState() }}
    
    private var isConfirmPass = false { didSet {updateButtonState() }}
    
    private var passwordStrenght: PasswordStreght = .veryWeak { didSet {updateButtonState() }}
    
    
    //MARK: - Life cicle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        willStartKeyboard()
    }
    
    //MARK: - Methods
    
    @IBAction private func emailTFAction(_ sender: UITextField) {
        if let email = sender.text, !email.isEmpty, VerificationService.isValidEmail(email) {
            isValidEmail = true
        } else {
            isValidEmail = false
            errorEmail.text = "Please enter your email"
        }
        errorEmail.isHidden = isValidEmail
    }
    
    @IBAction private func passwordTFAction(_ sender: UITextField) {
        if let password = sender.text, !password.isEmpty {
            passwordStrenght = VerificationService.isValidPassword(pass: password)
        } else {
            passwordStrenght = .veryWeak
        }
        errorPassword.isHidden = passwordStrenght != .veryWeak
        errorPassword.text = "Your password is incorrect"
        setupPasswordsIndicator()
    }
    
    @IBAction private func confirmPasswordTFAction(_ sender: UITextField) {
        if let confPassText = sender.text, !confPassText.isEmpty,
           let passText = passwordTF.text, !passText.isEmpty {
            isConfirmPass = VerificationService.isPassConfirm(pass: passText, confirmPass: confPassText)
        } else {
            isConfirmPass = false
        }
        errorConfirmPass.isHidden = isConfirmPass
        errorConfirmPass.text = "Repeat your password, please"
    }
    
    @IBAction private func signInButton() {
        navigationController?.popToRootViewController(animated: true)
    }
    
    @IBAction private func continueButtonAction() {
    }
    
    
    @IBAction private func tapRecognizer(_ sender: Any) {
        emailTF.resignFirstResponder()
        passwordTF.resignFirstResponder()
        nameTF.resignFirstResponder()
        confirmPasswordTF.resignFirstResponder()
    }
    
    
    //MARK: - Functions
    
    private func updateButtonState() {
        continueButton.isEnabled = isValidEmail && isConfirmPass && passwordStrenght != .veryWeak
        continueButton.alpha = 1.0
    }
    
    private func setupPasswordsIndicator() {
        for (index, view) in strongPasswordIndicator.enumerated() {
            if index <= (passwordStrenght.rawValue - 1) {
                view.alpha = 1
            } else {
                view.alpha = 0.1
            }
        }
    }
    
    private func setupUI() {
        strongPasswordIndicator.forEach { view in
            view.alpha = 0.1
        }
        continueButton.alpha = 0.3
    }
    
    //MARK: - Keyboard
    
    private func willStartKeyboard() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc private func keyboardWillShow(notification: Notification) {
        guard let keyboardSize = (notification.userInfo? [UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {return}
        let content = UIEdgeInsets(top: 0.0, left: 0.0, bottom: keyboardSize.height, right: 0.0)
        scrollView.contentInset = content
        scrollView.scrollIndicatorInsets = content
    }
    
    @objc private func keyboardHide() {
        let content = UIEdgeInsets(top: 0.0, left: 0.0, bottom: 0.0, right: 0.0)
        scrollView.contentInset = content
        scrollView.scrollIndicatorInsets = content
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
