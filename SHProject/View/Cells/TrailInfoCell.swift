//
//  TrailInfoCell.swift
//  SHProject
//
//  Created by sihon321 on 14/04/2019.
//  Copyright © 2019 sihon. All rights reserved.
//

import UIKit

class TrailInfoCell: UITableViewCell {
  
  
  @IBOutlet weak var syncImageView: UIImageView!
  
  @IBOutlet weak var headerImageView: UIImageView!
  
  @IBOutlet weak var nameLabel: UILabel!
  
  @IBOutlet weak var contentLabel: UILabel!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
  }
  
  func config(_ trail: [Trail]?, _ post: PostBlog?) {
    guard let trail = trail?.first else {
      debugPrint("trail is Empty!")
      return
    }
    
    if trail.blog?.name == post?.name {
      syncImageView.image = UIImage(named: "baseline_undo_black_18pt")
    } else {
      syncImageView.image = UIImage(named: "baseline_sync_black_18pt")
    }
    
    let url = URL(string: trail.blog?.theme?.headerImage ?? "")
    headerImageView.render(img: url)
    nameLabel.text = trail.blog?.name
    setupContentLabel(trail.content)
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

extension TrailInfoCell {
  static func height() -> CGFloat {
    return 200.0
  }
}
