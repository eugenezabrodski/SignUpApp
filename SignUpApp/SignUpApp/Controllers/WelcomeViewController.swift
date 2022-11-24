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
        navigationController?.popToRootViewController(animated: true)
    }
    
    private func setupUI() {
        infoLabel.text = "\(userModel?.name ?? "User") welcome to our app. Together we are save the world"
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
