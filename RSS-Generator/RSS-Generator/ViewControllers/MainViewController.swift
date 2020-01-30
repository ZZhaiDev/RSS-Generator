//
//  ViewController.swift
//  RSS-Generator
//
//  Created by zijia on 1/29/20.
//  Copyright © 2020 zijia. All rights reserved.
//

import UIKit

private let mainCellId = "mainCellId"

class MainViewController: UITableViewController {
    
    var dataSource: [RSSResult]? {
        didSet {
            tableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        makeApiCall()
    }

}

// MARK: -- TableView setupUI, MakeApiCall
extension MainViewController {
    fileprivate func setupUI() {
        view.backgroundColor = .white
        tableView.register(MainViewCell.self, forCellReuseIdentifier: mainCellId)
        tableView.rowHeight = MainViewCell.cellHeight
        self.title = "Albums"
    }
    
    fileprivate func makeApiCall() {
        let str = "https://rss.itunes.apple.com/api/v1/us/apple-music/coming-soon/all/25/explicit.json"
        NetworkLayer.shareInstance.getRSSData(str: str) { (result) in
            switch result {
            case .error(let error):
                print(error.localizedDescription)
            case .success(let results):
                self.dataSource = results
            }
        }
    }
}


// MARK: -- TableView DataSource, delegate
extension MainViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: mainCellId, for: indexPath) as! MainViewCell
        cell.dataSource = dataSource?[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVC = DetailViewController()
        detailVC.dataSource = dataSource?[indexPath.row]
        navigationController?.pushViewController(detailVC, animated: true)
    }
}



