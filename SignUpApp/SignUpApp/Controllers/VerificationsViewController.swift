//
//  VerificationsViewController.swift
//  SignUpApp
//
//  Created by Евгений Забродский on 23.11.22.
//

import UIKit

class VerificationsViewController: UIViewController {
    
    var userModel: UserModel?
    
    var randomInt = Int.random(in: 100000 ... 999999)
    
    @IBOutlet weak var infoLabel: UILabel!
    
    @IBOutlet weak var codeTF: UITextField!
    
    @IBOutlet weak var erorrCode: UILabel!
    
    @IBOutlet weak var constraintStackView: NSLayoutConstraint!
    
    @IBOutlet weak var refreshButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        willStartKeyboard()

    }
    
    @IBAction func codeTFAction(_ sender: UITextField) {
        guard let text = sender.text, !text.isEmpty, text == randomInt.description else { erorrCode.isHidden = false
            erorrCode.text = "Please click Refresh"
            codeTF.isUserInteractionEnabled = false
            refreshButton.isEnabled = true
            return
        }
        performSegue(withIdentifier: "goToWelcomeVC", sender: nil)
    }
    
    @IBAction func refreshButtonAction(_ sender: UIButton) {
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
    

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destVC = segue.destination as? WelcomeViewController
        else { return }
        destVC.userModel = userModel
    }


}
