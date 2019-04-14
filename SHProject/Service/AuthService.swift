//
//  AuthService.swift
//  SHProject
//
//  Created by sihon321 on 12/04/2019.
//  Copyright © 2019 sihon. All rights reserved.
//

import UIKit
import OAuthSwift
import SafariServices

class AuthService {
  
  static let shared = AuthService()
  
  var viewFrame: CGRect?
  
  private var oauthswift: OAuthSwift?
  
  private lazy var internalWebViewController: WebViewController = {
    let controller = WebViewController()
    controller.view = UIView(frame: viewFrame ?? .zero)
    controller.delegate = self
    controller.viewDidLoad()
    return controller
  }()
  
  init() { }
  
  func requestToken(_ completion: @escaping (Bool) -> Void) {
    let oauthswift = OAuth1Swift(
      consumerKey:      KeyConstants.consumerKey,
      consumerSecret:   KeyConstants.secretKey,
      requestTokenUrl: "https://www.tumblr.com/oauth/request_token",
      authorizeUrl:    "https://www.tumblr.com/oauth/authorize",
      accessTokenUrl:  "https://www.tumblr.com/oauth/access_token"
    )
    
    self.oauthswift = oauthswift
    
    // authorize
    oauthswift.authorizeURLHandler = getURLHandler()
    let _ = oauthswift.authorize(
      withCallbackURL: URL(string: "shproject://oauth-callback/tumblr")!,
      success: { credential, response, parameters in
        print("auth token: \(credential.oauthToken)")
        print("secret token: \(credential.oauthTokenSecret)")
        completion(true)
    },
      failure: { error in
        print(error.description)
        completion(false)
    })
    
  }
  
  func requestUserInfo(_ completion: @escaping (Bool, UserInfo?) -> Void) {
    
    let _ = oauthswift?.client.get(TumblrUrl.userInfo.path,
                                   headers: ["Accept":"application/json"],
                                   success: { response in
                                    var userInfo: UserInfo?
                                    do {
                                      userInfo = try UserInfo(data: response.data)
                                    } catch {
                                      print(error)
                                      userInfo = nil
                                    }
                                    completion(true, userInfo)
    },
                                   failure: { error in
                                    print(error)
                                    completion(false, nil)
    })
  }
  
  func requestDashBoard(_ offset: Int = 0,
                        _ completion: @escaping (Bool, DashboardInfo?) -> Void) {
    
    let _ = oauthswift?.client.get(TumblrUrl.dashboard.path,
                                   parameters: ["offset": offset],
                                   headers: ["Accept": "application/json"],
                                   success: { response in
                                    var dashBoardInfo: DashboardInfo?
                                    do {
                                      dashBoardInfo = try DashboardInfo(data: response.data)
                                    } catch {
                                      print(error)
                                      dashBoardInfo = nil
                                    }
                                    completion(true, dashBoardInfo)
    },
                                   failure: { error in
                                    print(error)
                                    completion(false, nil)
    })
  }
  
  private func getURLHandler() -> OAuthSwiftURLHandlerType {
    return internalWebViewController
  }
  
}

extension AuthService: OAuthWebViewControllerDelegate {
  
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
