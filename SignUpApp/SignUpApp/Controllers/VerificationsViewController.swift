//
//  VerificationsViewController.swift
//  SignUpApp
//
//  Created by Евгений Забродский on 23.11.22.
//

import UIKit

final class VerificationsViewController: UIViewController {
    
    //MARK: - Properties
    
    var userModel: UserModel?
    
    var randomInt = Int.random(in: 100000 ... 999999)
    
    @IBOutlet private weak var infoLabel: UILabel!
    
    @IBOutlet private weak var codeTF: UITextField!
    
    @IBOutlet private weak var erorrCode: UILabel!
    
    @IBOutlet private weak var constraintStackView: NSLayoutConstraint!
    
    @IBOutlet private weak var refreshButton: UIButton!
    
    //MARK: - Life cicle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        willStartKeyboard()
        addDoneButton(codeTF)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        codeTF.text = ""
    }
    
    //MARK: - Methods
    
    @IBAction private func codeTFAction(_ sender: UITextField) {
        guard let text = sender.text, !text.isEmpty, text == randomInt.description else { erorrCode.isHidden = false
            erorrCode.text = "Please click Refresh"
            codeTF.isUserInteractionEnabled = false
            refreshButton.isEnabled = true
            return
        }
        performSegue(withIdentifier: "goToWelcomeVC", sender: nil)
    }
    
    @IBAction private func refreshButtonAction(_ sender: UIButton) {
        randomInt = Int.random(in: 100000 ... 900000)
        codeTF.isUserInteractionEnabled = true
        infoLabel.text = "Enter your new secret code '\(randomInt)' from \(userModel?.email ?? "")"
        refreshButton.isEnabled = false
        erorrCode.isHidden = true
    }
    
    
    
    private func setupUI() {
        infoLabel.text = "Enter your secret code '\(randomInt)' from \(userModel?.email ?? "")"
        refreshButton.isHidden = false
    }
    
    //MARK: - Keyboard
    
    private func willStartKeyboard() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc private func keyboardWillShow(notification: Notification) {
        guard let keyboardSize = (notification.userInfo? [UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else { return }
        constraintStackView.constant -= keyboardSize.height / 2
    }
    
    @objc private func keyboardHide(notification: Notification) {
        guard let keyboardSize = (notification.userInfo? [UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else { return }
        constraintStackView.constant += keyboardSize.height / 2
    }
    
    private func addDoneButton(_ textField: UITextField) {
        let keyboardToolbar = UIToolbar()
        textField.inputAccessoryView = keyboardToolbar
        keyboardToolbar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "GO",
                                         style: .plain,
                                         target: codeTFAction(_:),
                                         action: #selector(didTapDone))
        
        let flexBarButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace,
                                            target: nil,
                                            action: nil)
        
        keyboardToolbar.items = [flexBarButton, doneButton]
    }
    
    @objc private func didTapDone() {
        codeTFAction(codeTF.self)
    }
    

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destVC = segue.destination as? WelcomeViewController
        else { return }
        destVC.userModel = userModel
    }


}
