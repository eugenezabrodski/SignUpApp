//
//  WelcomeViewController.swift
//  SignUpApp
//
//  Created by Евгений Забродский on 24.11.22.
//

import UIKit

final class WelcomeViewController: UIViewController {

    //MARK: - Properties
    
   var userModel: UserModel?
    
   @IBOutlet private weak var infoLabel: UILabel!
    
    //MARK: - Life cicle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    //MARK: - Methods
    
    @IBAction private func continueButtonAction(_ sender: Any) {
        guard let userModel = userModel else { return }
        UserDefaultService.saveUserModel(userModel: userModel)
        navigationController?.popToRootViewController(animated: true)
    }
    
    private func setupUI() {
        infoLabel.text = "\(userModel?.name ?? "User") welcome to our app. Together we are save the world"
    }
    
}
