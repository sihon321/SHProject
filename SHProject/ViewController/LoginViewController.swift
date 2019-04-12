//
//  LoginViewController.swift
//  SHProject
//
//  Created by sihon321 on 11/04/2019.
//  Copyright © 2019 sihon. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
  
  @IBOutlet weak var mainLogo: UIImageView!
  
  @IBOutlet weak var indicatorView: UIActivityIndicatorView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    indicatorView.isHidden = true
    AuthService.shared.viewFrame = view.frame
  }
  
  @IBAction func touchUpSignIn(_ sender: Any) {
    indicatorView.isHidden = false
    indicatorView.startAnimating()
    
    AuthService.shared.requestToken { [weak self] isSuccess in
      guard let strongSelf = self else { return }
      
      strongSelf.indicatorView.isHidden = true
      strongSelf.indicatorView.stopAnimating()
      
      if isSuccess,
        let viewController = strongSelf.storyboard?.instantiateViewController(withIdentifier: "ListViewController") as? ListViewController {
        strongSelf.navigationController?.setViewControllers([viewController], animated: false)
      }
    }
  }
  
}
