//
//  TrailInfoCell.swift
//  SHProject
//
//  Created by sihon321 on 14/04/2019.
//  Copyright © 2019 sihon. All rights reserved.
//

import UIKit

class TrailInfoCell: UITableViewCell, TumblrImage {
  
  @IBOutlet weak var syncImageView: UIImageView!
  
  @IBOutlet weak var headerImageView: UIImageView!
  
  @IBOutlet weak var nameLabel: UILabel!
  
  @IBOutlet weak var contentLabel: UILabel!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
  }
  
  func config(_ trail: [Trail]?, _ post: PostBlog?) {
    guard let trail = trail else {
      debugPrint("trail is Empty!")
      return
    }
    
    if trail.first?.blog?.name == post?.name {
      syncImageView.image = UIImage(named: "baseline_undo_black_18pt")
    } else {
      syncImageView.image = UIImage(named: "baseline_sync_black_18pt")
    }
    
    if trail.isEmpty == false {
      let urlstr = trail.first?.blog?.theme?.headerImage ?? ""
      setImage(headerImageView, urlstr, false, 10)
    } else {
      headerImageView.image = UIImage(named: "placeholderImage")
    }
    nameLabel.text = trail.first?.blog?.name ?? post?.name ?? ""
    setupContentLabel(trail.first?.content ?? post?.description ?? "")
  }

  private func setupContentLabel(_ content: String?) {
    if let html = content?.data(using: .unicode) {
      do {
        contentLabel.attributedText = try NSAttributedString(data: html,
                                                                 options: [.documentType: NSAttributedString.DocumentType.html],
                                                                 documentAttributes: nil)
      } catch {
        debugPrint("couldn't not parse \(html): \(error)")
      }
    }
  }
}
