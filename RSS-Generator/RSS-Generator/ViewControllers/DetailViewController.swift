//
//  DetailViewController.swift
//  RSS-Generator
//
//  Created by zijia on 1/29/20.
//  Copyright © 2020 zijia. All rights reserved.
//

import UIKit

private let genreCellId = "genreCellId"

class DetailViewController: UIViewController {
    
    var dataSource: RSSResult? {
        didSet {
            guard let dataSource = dataSource else { return }
            self.title = dataSource.name
            albumNameLable.text = "Album: " + dataSource.name
            artistNameLable.text = "Artist: " + dataSource.artistName
            releaseDateLabel.text = "Released Date: " + dataSource.releaseDate
            copyRightLabel.text = dataSource.copyright
            // for image cache, we need SDWebImage to help us doing the memory cahe and disk cahce.
            imageV.loadImage(urlString: dataSource.artworkUrl100)
            genreTableView.reloadData()
        }
    }
    
    var imageV: CatchedImageView = {
        let iv = CatchedImageView(frame: .zero)
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        return iv
    }()
    
    var blackBGView: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = UIColor.init(white: 0, alpha: 0.5)
        return view
    }()
    
    var albumNameLable: UILabel = {
        let label = UILabel(frame: .zero)
        label.textColor = UIColor.white
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textAlignment = .right
        return label
    }()
    
    var artistNameLable: UILabel = {
        let label = UILabel(frame: .zero)
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.textAlignment = .right
        return label
    }()
    
    var releaseDateLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.textColor = UIColor.darkGray
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textAlignment = .right
        return label
    }()
    
    var copyRightLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.textColor = .gray
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .center
        return label
    }()
    
    lazy var albumButton: UIButton = { [weak self] in
        let button = UIButton(frame: .zero)
        button.backgroundColor = .red
        button.setTitle("What to do here?", for: .normal)
        button.addTarget(self, action: #selector(albumButtonClicked), for: .touchUpInside)
        return button
    }()
    
    lazy var genreTableView: UITableView = { [weak self] in
        let tv = UITableView(frame: .zero)
        tv.dataSource = self
        tv.delegate = self
        tv.tableFooterView = UIView()
        tv.register(UITableViewCell.self, forCellReuseIdentifier: genreCellId)
        return tv
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        view.backgroundColor = .white
    }
    
    @objc fileprivate func albumButtonClicked() {
        print("I am not sure what to do here")
    }

}


extension DetailViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource?.genres.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: genreCellId)
        cell.selectionStyle = .none
        if let datas = dataSource?.genres {
            cell.textLabel?.text = "Name: " + datas[indexPath.row].name
            cell.detailTextLabel?.text = "GenreId: " + datas[indexPath.row].genreId
        }
        return cell
    }
    
}

extension DetailViewController {
    fileprivate func setupUI() {
        view.addSubview(imageV)
        imageV.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: UIScreen.main.bounds.size.width)
        
        imageV.addSubview(blackBGView)
        blackBGView.anchor(top: nil, left: imageV.leftAnchor, bottom: imageV.bottomAnchor, right: imageV.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 70)
        
        let rightPadding: CGFloat = 20
        blackBGView.addSubview(albumNameLable)
        albumNameLable.anchor(top: blackBGView.topAnchor, left: blackBGView.leftAnchor, bottom: nil, right: blackBGView.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: rightPadding, width: 0, height: 40)
        
        blackBGView.addSubview(artistNameLable)
        artistNameLable.anchor(top: albumNameLable.bottomAnchor, left: blackBGView.leftAnchor, bottom: blackBGView.bottomAnchor, right: blackBGView.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: rightPadding, width: 0, height: 0)
        
        let labelHeight: CGFloat = 30
        view.addSubview(releaseDateLabel)
        releaseDateLabel.anchor(top: imageV.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: rightPadding, width: 0, height: labelHeight)
        
        let buttonPadding: CGFloat = 20
        let buttonHeight: CGFloat = 50
        view.addSubview(albumButton)
        albumButton.anchor(top: nil, left: view.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: buttonPadding, paddingBottom: buttonPadding, paddingRight: buttonPadding, width: 0, height: buttonHeight)
        albumButton.layer.cornerRadius = buttonHeight/2
        albumButton.layer.masksToBounds = true
        
        let tableViewPadding: CGFloat = 10
        view.addSubview(genreTableView)
        genreTableView.anchor(top: releaseDateLabel.bottomAnchor, left: view.leftAnchor, bottom: albumButton.topAnchor, right: view.rightAnchor, paddingTop: tableViewPadding, paddingLeft: tableViewPadding, paddingBottom: tableViewPadding, paddingRight: tableViewPadding, width: 0, height: 0)
        
        view.addSubview(copyRightLabel)
        copyRightLabel.anchor(top: albumButton.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 10, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
    }
}
