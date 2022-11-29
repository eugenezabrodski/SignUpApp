//
//  PersonalViewController.swift
//  SignUpApp
//
//  Created by Евгений Забродский on 28.11.22.
//

import UIKit

final class PersonalViewController: UIViewController {

    //MARK: - Life cicle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
    }
    
    //MARK: - Methods
    
    @IBAction func logOutAction(_ sender: Any) {
        navigationController?.popToRootViewController(animated: true)
    }

    
    @IBAction func deleteAccountAction(_ sender: Any) {
        UserDefaultService.cleanUserDefault()
        navigationController?.popToRootViewController(animated: true)
    }
    


}
