//
//  SplashViewController.swift
//  iOS Interview Mark Boleigha
//
//  Created by Mark Boleigha on 17/01/2022.
//

import UIKit

class SplashViewController: UIViewController {
    let app = AppDelegate.shared

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // Do any additional setup after loading the view.
        guard app.keystore.string(forKey: "API_KEY") != nil else {
            app.setRootViewController(controller: LoginViewController())
            return
        }
    }
    

}
