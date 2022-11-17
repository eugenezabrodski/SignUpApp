//
//  SignUpViewController.swift
//  SignUpApp
//
//  Created by Евгений Забродский on 17.11.22.
//

import UIKit

class SignUpViewController: UIViewController {

    // MARK: - IBOutlets
    
    @IBOutlet weak var emailTF: UITextField!
    
    @IBOutlet weak var errorEmail: UILabel!
    
    @IBOutlet weak var nameTF: UITextField!
    
    @IBOutlet weak var passwordTF: UITextField!
    
    @IBOutlet weak var errorPassword: UILabel!
    
    @IBOutlet var strongPasswordIndicator: [UIView]!
    
    @IBOutlet weak var confirmPasswordTF: UITextField!
    
    @IBOutlet weak var errorConfirmPass: UILabel!
    
    @IBOutlet weak var continueButton: UIButton!
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    //MARK: - Properties
    
    private var isValidEmail = false { didSet {updateButtonState() }}
    
    private var isConfirmPass = false { didSet {updateButtonState() }}
    
    private var passwordStrenght: PasswordStreght = .veryWeak { didSet {updateButtonState() }}
    
    
    //MARK: - Life cicle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
    }
    
    //MARK: - Methods
    
    @IBAction func emailTFAction(_ sender: UITextField) {
        if let email = sender.text, !email.isEmpty, VerificationService.isValidEmail(email) {
            isValidEmail = true
        } else {
            isValidEmail = false
            errorEmail.text = "Please enter your email"
        }
        errorEmail.isHidden = isValidEmail
    }
    
    @IBAction func passwordTFAction(_ sender: UITextField) {
        if let password = sender.text, !password.isEmpty {
            passwordStrenght = VerificationService.isValidPassword(pass: password)
        } else {
            passwordStrenght = .veryWeak
        }
        errorPassword.isHidden = passwordStrenght != .veryWeak
        errorPassword.text = "Your password is uncorrect"
        setupPasswordsIndicator()
    }
    
    @IBAction func confirmPasswordTFAction(_ sender: UITextField) {
        if let confPassText = sender.text, !confPassText.isEmpty,
           let passText = passwordTF.text, !passText.isEmpty {
            isConfirmPass = VerificationService.isPassConfirm(pass: passText, confirmPass: confPassText)
        } else {
            isConfirmPass = false
        }
        errorConfirmPass.isHidden = isConfirmPass
        errorConfirmPass.text = "Repeat your password, please"
    }
    
    @IBAction func signInButton() {
    }
    
    @IBAction func continueButtonAction() {
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
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
