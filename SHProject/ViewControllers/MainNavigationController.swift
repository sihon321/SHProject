//
//  MainNavigationController.swift
//  SHProject
//
//  Created by sihon321 on 10/04/2019.
//  Copyright © 2019 sihon. All rights reserved.
//

import UIKit

class MainNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
      if let viewController = storyboard?
        .instantiateViewController(withIdentifier: "LoginViewController")
        as? LoginViewController {
        self.pushViewController(viewController, animated: false)
      }
    }

}
