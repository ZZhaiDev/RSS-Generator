//
//  MainViewCell.swift
//  RSS-Generator
//
//  Created by zijia on 1/29/20.
//  Copyright © 2020 zijia. All rights reserved.
//

import UIKit

class MainViewCell: UITableViewCell {
    
    static let cellHeight: CGFloat = 150
    
    var imageV: CatchedImageView = {
        let iv = CatchedImageView(frame: .zero)
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        return iv
    }()
    
    var albumNameLable: UILabel = {
        let label = UILabel(frame: .zero)
        label.textColor = UIColor.darkGray
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.numberOfLines = 0
        return label
    }()
    
    var artistNameLable: UILabel = {
        let label = UILabel(frame: .zero)
        label.textColor = .gray
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.textAlignment = .right
        return label
    }()
    
    var dataSource: RSSResult? {
        didSet {
            guard let dataSource = dataSource else { return }
            albumNameLable.text = "Album: " + dataSource.name
            artistNameLable.text = "Artist: " + dataSource.artistName
            
            // for image cache, we need SDWebImage to help us doing the memory cahe and disk cahce.
            imageV.loadImage(urlString: dataSource.artworkUrl100)
        }
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension MainViewCell {
    
    fileprivate func setupUI() {
        
        self.accessoryType = .disclosureIndicator
        
        let imagePadding: CGFloat = 5
        let width = CGFloat(MainViewCell.cellHeight) - 2*imagePadding
        self.addSubview(imageV)
        imageV.anchor(top: self.topAnchor, left: self.leftAnchor, bottom: self.bottomAnchor, right: nil, paddingTop: imagePadding, paddingLeft: imagePadding, paddingBottom: imagePadding, paddingRight: 0, width: width, height: 0)
        imageV.layer.cornerRadius = width/2
        
        let labelPadding: CGFloat = 20
        let rightPadding: CGFloat = 40
        self.addSubview(albumNameLable)
        albumNameLable.anchor(top: imageV.topAnchor, left: imageV.rightAnchor, bottom: nil, right: self.rightAnchor, paddingTop: labelPadding, paddingLeft: labelPadding, paddingBottom: 0, paddingRight: rightPadding, width: 0, height: 0)
        
        self.addSubview(artistNameLable)
        artistNameLable.anchor(top: albumNameLable.bottomAnchor, left: imageV.rightAnchor, bottom: nil, right: self.rightAnchor, paddingTop: 30, paddingLeft: labelPadding, paddingBottom: 0, paddingRight: rightPadding, width: 0, height: 0)
        
    }
}
