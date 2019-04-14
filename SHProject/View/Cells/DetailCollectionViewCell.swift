//
//  DetailCollectionViewCell.swift
//  SHProject
//
//  Created by sihon321 on 10/04/2019.
//  Copyright © 2019 sihon. All rights reserved.
//

import UIKit

class DetailCollectionViewCell: UICollectionViewCell {
  
  enum SectionType: Int {
    case image, blog, trail
  }
  
  @IBOutlet weak var tableView: UITableView!
  
  var post: PostElement? = nil
  
  private var image: UIImage? {
    didSet {
        tableView.reloadData()
    }
  }
  
  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
    tableView.register(ImageViewCell.self)
    tableView.register(BlogInfoCell.self)
    tableView.register(TrailInfoCell.self)
  }
  
  func config(_ post: PostElement?, _ image: UIImage?) {
    
    self.post = post
    self.image = image
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    
    tableView.reloadData()
  }
}

extension DetailCollectionViewCell: UITableViewDelegate {
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    let sectionType = SectionType(rawValue: indexPath.section)!
    
    switch sectionType {
    case .image:
      return ImageViewCell.height()
    case .blog:
      return BlogInfoCell.height()
    case .trail:
      return TrailInfoCell.height()
    }
  }
}

extension DetailCollectionViewCell: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    let sectionType = SectionType(rawValue: section)!
    switch sectionType {
    case .image:
      return 1
    case .blog:
      return 1
    case .trail:
      return 1
    }
  }
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return 3
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let sectionType = SectionType(rawValue: indexPath.section)!
    
    switch sectionType {
    case .image:
      let cell = tableView.dequeueReusableCell(withIdentifier: ImageViewCell.reuseIdentifier, for: indexPath) as! ImageViewCell
      cell.url = URL(string: post?.photos?.first?.originalSize?.url ?? "")
      
      return cell
    case .blog:
      let cell = tableView.dequeueReusableCell(withIdentifier: BlogInfoCell.reuseIdentifier, for: indexPath) as! BlogInfoCell
      cell.config(post, image)
      
      return cell
    case .trail:
      let cell = tableView.dequeueReusableCell(withIdentifier: TrailInfoCell.reuseIdentifier) as! TrailInfoCell
      cell.config(post?.trail, post?.blog)
      
      return cell
    }
  }

}
