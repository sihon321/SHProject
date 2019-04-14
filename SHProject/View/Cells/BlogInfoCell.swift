//
//  BlogInfoCell.swift
//  SHProject
//
//  Created by sihon321 on 13/04/2019.
//  Copyright © 2019 sihon. All rights reserved.
//

import UIKit

class BlogInfoCell: UITableViewCell {
  
  @IBOutlet weak var mainimageView: UIImageView!
  
  @IBOutlet weak var nameLabel: UILabel!
  
  @IBOutlet weak var titleLabel: UILabel!
  
  @IBOutlet weak var descriptionLabel: UILabel!
  
  @IBOutlet weak var noteCountLabel: UILabel!
  
  @IBOutlet weak var dateLabel: UILabel!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
  }
  
  func config(_ post: PostElement?, _ image: UIImage?) {
    
    setupImageView(image)
    nameLabel.text = post?.blog?.name ?? ""
    titleLabel.text = post?.blog?.title ?? ""
    setupDescriptionLabel(post?.blog?.description)
    if let count = post?.noteCount {
      noteCountLabel.text = "반응 \(count.commaRepresentation)개"
    }
    dateLabel.text = post?.date?.convertDateString()
  }

  override func layoutSubviews() {
    super.layoutSubviews()
    
  }
  
  private func setupImageView(_ image: UIImage?) {
    mainimageView.layer.cornerRadius = mainimageView.frame.width / 2
    mainimageView.clipsToBounds = true
    mainimageView.image = image
  }
  
  private func setupDescriptionLabel(_ decript: String?) {
    if let html = decript?.data(using: .unicode) {
      do {
        descriptionLabel.attributedText = try NSAttributedString(data: html,
                                                                 options: [.documentType: NSAttributedString.DocumentType.html],
                                                                 documentAttributes: nil)
      } catch {
        debugPrint("couldn't not parse \(html): \(error)")
      }
    }
  }
}

extension BlogInfoCell {
  static func height() -> CGFloat {
    return 110.0
  }
  
}
