//
//  UserInfoCell.swift
//  SHProject
//
//  Created by sihon321 on 12/04/2019.
//  Copyright © 2019 sihon. All rights reserved.
//

import UIKit

class UserInfoCell: UICollectionViewCell {
  
  @IBOutlet weak var titleLabel: UILabel!
  
  @IBOutlet weak var postLabel: UILabel!
  
  @IBOutlet weak var likeLabel: UILabel!
  
  @IBOutlet weak var followingLabel: UILabel!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
  }
  
  func config(_ userInfo: UserInfo?) {
    guard let userInfo = userInfo else {
      debugPrint("userInfo is Empty!")
      return
    }
    let user = userInfo.response?.user
    titleLabel.text = user?.blogs?.first?.title
    postLabel.text = String(user?.blogs?.first?.posts ?? 0)
    likeLabel.text = String(user?.likes ?? 0)
    followingLabel.text = String(user?.following ?? 0)
  }
}

extension UserInfoCell {
  static func size() -> CGSize {
    return CGSize(width: UIScreen.width - 30.0, height: 80.0)
  }
}
