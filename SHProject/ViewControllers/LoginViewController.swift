//
//  LoginViewController.swift
//  SHProject
//
//  Created by sihon321 on 11/04/2019.
//  Copyright © 2019 sihon. All rights reserved.
//

import UIKit
import OAuthSwift
import SafariServices

class LoginViewController: UIViewController {
  
  @IBOutlet weak var mainLogo: UIImageView!
  
  @IBOutlet weak var indicatorView: UIActivityIndicatorView!
  
  var oauthswift: OAuthSwift?
  
  lazy var internalWebViewController: WebViewController = {
    let controller = WebViewController()
    controller.view = UIView(frame: view.bounds)
    controller.delegate = self
    controller.viewDidLoad()
    return controller
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    indicatorView.isHidden = true
  }
  
  @IBAction func touchUpSignIn(_ sender: Any) {
    
    let oauthswift = OAuth1Swift(
      consumerKey:      KeyConstants.consumerKey,
      consumerSecret:   KeyConstants.secretKey,
      requestTokenUrl: "https://www.tumblr.com/oauth/request_token",
      authorizeUrl:    "https://www.tumblr.com/oauth/authorize",
      accessTokenUrl:  "https://www.tumblr.com/oauth/access_token"
    )
    
    self.oauthswift = oauthswift
    
    indicatorView.isHidden = false
    indicatorView.startAnimating()
    // authorize
    oauthswift.authorizeURLHandler = getURLHandler()
    let _ = oauthswift.authorize(
      withCallbackURL: URL(string: "shproject://oauth-callback/tumblr")!,
      success: { credential, response, parameters in
        self.testTumblr(oauthswift)
        self.indicatorView.stopAnimating()
        self.indicatorView.isHidden = true
        if let viewController = self.storyboard?.instantiateViewController(withIdentifier: "ListViewController") as? ListViewController {
          self.navigationController?.setViewControllers([viewController], animated: false)
        }
    },
      failure: { error in
        print(error.description)
    })
    
  }
  
  func testTumblr(_ oauthswift: OAuth1Swift){
    let _ = oauthswift.client.get("https://api.tumblr.com/v2/user/info",
                                  headers: ["Accept":"application/json"],
                                  success: { response in
                                    if let jsonDict = try? response.jsonObject(options: .allowFragments),
                                      let dico = jsonDict as? [String: Any] {
                                      print(dico)
                                    } else {
                                      print("no json response")
                                    }},
                                  failure: { error in print(error) })
    
    let url = "good.tumblr.com"
    let _ = oauthswift.client.post("https://api.tumblr.com/v2/user/follow",
                                   parameters: ["url": url],
                                   success: { response in
                                    let dataString = response.string!
                                    print(dataString) },
                                   failure: { error in print(error) })
  }
  
  func getURLHandler() -> OAuthSwiftURLHandlerType {
    if internalWebViewController.parent == nil {
      self.addChild(internalWebViewController)
    }
    return internalWebViewController
  }
}

extension LoginViewController: OAuthWebViewControllerDelegate {
  
  func oauthWebViewControllerDidPresent() {
    
  }
  
  func oauthWebViewControllerDidDismiss() {
    
  }
  
  func oauthWebViewControllerWillAppear() {
    
  }
  
  func oauthWebViewControllerDidAppear() {
    
  }
  
  func oauthWebViewControllerWillDisappear() {
    
  }
  
  func oauthWebViewControllerDidDisappear() {
    oauthswift?.cancel()
  }
}
