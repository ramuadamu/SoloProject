//
//  WatchingViewController.swift
//  SoloProject
//
//  Created by Ramu on 2/14/19.
//  Copyright © 2019 Ramu. All rights reserved.
//

import UIKit

class WatchingViewController: UIViewController {
    
    @IBOutlet weak var favoriteTableView: UITableView!
    
    var favoriteSpectacle = [FavoriteSpectacles]() {
        didSet {
            self.favoriteTableView.reloadData()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    favoriteTableView.dataSource = self
    favoriteTableView.delegate = self
        getFavoriteSpectacle()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        getFavoriteSpectacle()
    }
    func getFavoriteSpectacle() {
        self.favoriteSpectacle = SpectacleWatchListDataManager.fetchFavoriteSpectacleFromDocumentDirectory()
    }
}
extension WatchingViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return SpectacleWatchListDataManager.fetchFavoriteSpectacleFromDocumentDirectory().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = favoriteTableView.dequeueReusableCell(withIdentifier: "WatchingListCell", for: indexPath) as! WatchListCell
        let watchlistSpectacle = SpectacleWatchListDataManager.fetchFavoriteSpectacleFromDocumentDirectory()[indexPath.row]
        cell.watchListImage.image = UIImage.init(data: watchlistSpectacle.spectacleImage)
        return cell
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let favorite = favoriteSpectacle[indexPath.row]
            SpectacleWatchListDataManager.delete(favoriteSpectacle: favorite, atIndex: indexPath.row)
            self.favoriteTableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
}
