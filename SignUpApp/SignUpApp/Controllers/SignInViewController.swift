//
//  SignInViewController.swift
//  SignUpApp
//
//  Created by Евгений Забродский on 17.11.22.
//

import UIKit

final class SignInViewController: UIViewController {

    //MARK: - Properties
    
    @IBOutlet private weak var constraintStackView: NSLayoutConstraint!
    
    @IBOutlet private weak var emailTF: UITextField!
    
    @IBOutlet private weak var passwordTF: UITextField!
    
    @IBOutlet private weak var errorLabel: UILabel!
    
    @IBOutlet private weak var signInButton: UIButton!
    
    private var isValidEmail = false { didSet {updateButtonState() }}
    
    private var isConfirmPass = false { didSet {updateButtonState() }}
    
    //MARK: - Life cicle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
        willStartKeyboard()
        goToMain()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        emailTF.text = ""
        passwordTF.text = ""
    }
    
    //MARK: - Methods
    
    @IBAction private func tfAction(_ sender: Any) {
        if let email = emailTF.text, let userModel = UserDefaultService.getUserModel(),
           email == userModel.email { isValidEmail = true }
        else {
            isValidEmail = false
        }
    }
    
   
    @IBAction private func passTFAction(_ sender: Any) {
        if let pass = passwordTF.text, let userModel = UserDefaultService.getUserModel(),
           pass == userModel.pass { isConfirmPass = true }
        else {
            isConfirmPass = false
        }
    }
    
    
    @IBAction private func signInAction(_ sender: Any) {
        errorLabel.isHidden = true
        guard let email = emailTF.text, let password = passwordTF.text,
        let userModel = UserDefaultService.getUserModel(),
        email == userModel.email,
        password == userModel.pass
        else {
            errorLabel.text = "Entered data is incorrect"
                errorLabel.isHidden = false
                return
        }
        performSegue(withIdentifier: "goToMainVC", sender: nil)
    }
    
    private func updateButtonState() {
        signInButton.isEnabled = isValidEmail && isConfirmPass
        }
    
    private func goToMain() {
        if UserDefaultService.getUserModel() != nil {
            performSegue(withIdentifier: "goToMainVC", sender: nil)
        }
    }
    
    //MARK: - Keyboard
    
    private func willStartKeyboard() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc private func keyboardWillShow(notification: Notification) {
        guard let keyboardSize = (notification.userInfo? [UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else { return }
//        constraintStackView.constant -= keyboardSize.height / 2
        self.view.frame.origin.y -=  keyboardSize.height / 2
    }
    
    @objc private func keyboardHide(notification: Notification) {
//        guard let keyboardSize = (notification.userInfo? [UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else { return }
        self.view.frame.origin.y = 0
    }


}
