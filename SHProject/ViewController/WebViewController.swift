//
//  WebViewController.swift
//  SHProject
//
//  Created by sihon321 on 11/04/2019.
//  Copyright © 2019 sihon. All rights reserved.
//

import UIKit
import OAuthSwift

class WebViewController: OAuthWebViewController {
  var targetURL: URL?
  let webView: UIWebView = UIWebView()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.webView.frame = view.frame
    self.webView.scalesPageToFit = true
    self.webView.delegate = self
    self.view.addSubview(self.webView)
    loadAddressURL()
  }
  
  override func handle(_ url: URL) {
    targetURL = url
    super.handle(url)
    self.loadAddressURL()
  }
  
  func loadAddressURL() {
    guard let url = targetURL else {
      return
    }
    let req = URLRequest(url: url)
    self.webView.loadRequest(req)
  }
}

extension WebViewController: UIWebViewDelegate {
  func webView(_ webView: UIWebView,
               shouldStartLoadWith request: URLRequest,
               navigationType: UIWebView.NavigationType) -> Bool {
    if let url = request.url, url.scheme == "shproject" {
      self.dismissWebViewController()
    }
    return true
  }
}

