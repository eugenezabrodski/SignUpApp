//
//  SignInViewController.swift
//  SignUpApp
//
//  Created by Евгений Забродский on 17.11.22.
//

import UIKit

final class SignInViewController: UIViewController {

    
    @IBOutlet weak var constraintStackView: NSLayoutConstraint!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
        willStartKeyboard()
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
