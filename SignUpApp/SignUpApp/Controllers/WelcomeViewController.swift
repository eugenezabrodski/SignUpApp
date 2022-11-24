//
//  WelcomeViewController.swift
//  SignUpApp
//
//  Created by Евгений Забродский on 24.11.22.
//

import UIKit

class WelcomeViewController: UIViewController {

    var userModel: UserModel?
    
    @IBOutlet weak var infoLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    @IBAction func continueButtonAction(_ sender: Any) {
        guard let userModel = userModel else { return }
        UserDefaultService.saveUserModel(userModel: userModel)
        navigationController?.popToRootViewController(animated: true)
    }
    
    private func setupUI() {
        infoLabel.text = "\(userModel?.name ?? "User") welcome to our app. Together we are save the world"
    }
    
}
