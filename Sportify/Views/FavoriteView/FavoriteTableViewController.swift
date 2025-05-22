//
//  FavoriteTableViewController.swift
//  Sportify
//
//  Created by Aya Emam on 15/05/2025.
//

import UIKit
import SDWebImage
import Reachability
class FavoriteTableViewController: UITableViewController , FavoritesViewProtocol{
    private var presenter: FavoritesPresenter!

    @IBOutlet weak var titleLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupPresenter()

    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.fetchFavoriteLeagues()
    }
    private func setupTableView() {
        titleLabel.text = "Favorites"
        let leagueTableCellnib = UINib(nibName: "LeaguesTableViewCell", bundle: nil)
        tableView.register(leagueTableCellnib, forCellReuseIdentifier: "leagueCell")
    }
    private func setupPresenter() {
        presenter = FavoritesPresenter(favoritesView: self)
    }
    // MARK: - Table view data source
//    override func numberOfSections(in tableView: UITableView) -> Int {
//        return 1
//    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.favoriteLeagues.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "leagueCell", for: indexPath) as! LeaguesTableViewCell
          
        let league = presenter.favoriteLeagues[indexPath.row]
          
        cell.leagueNameLabel.text = league.leagueName.isEmpty ? "League \(league.leagueId)" : league.leagueName
          
        if let logoUrlString = league.leagueLogo, !logoUrlString.isEmpty, let logoUrl = URL(string: logoUrlString) {
            cell.leagueImage.sd_setImage(with: logoUrl, placeholderImage: UIImage(systemName: "heart.fill")?.withTintColor(.red))
        } else {
            cell.leagueImage.image = UIImage(systemName: "heart.fill")
        }
        return cell
      }
     
    func displayFavoriteLeagues(leagues: [FavoriteLeagueModel]) {
        tableView.reloadData()
    }
    func leagueRemovedFromFavorites() {
        tableView.reloadData()
    }
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            showDeleteConfirmation(index: indexPath.row)
        }
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if isConnectedToInternet() {
            let leagueDetailVc = LeaguesDetailCollectionViewController()
            leagueDetailVc.leagueId = presenter?.favoriteLeagues[indexPath.row].leagueId
            leagueDetailVc.sport = presenter.favoriteLeagues[indexPath.row].sport
            leagueDetailVc.leagueName = presenter?.favoriteLeagues[indexPath.row].leagueName ?? "No name"
            leagueDetailVc.leagueImage = presenter?.favoriteLeagues[indexPath.row].leagueLogo ?? "star"
            navigationController?.pushViewController(leagueDetailVc, animated: true)
        }else{
            let alert = UIAlertController(
                title: "No Internet Connection",
                message: "Please check your internet connection and try again.",
                preferredStyle: .alert
            )
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            present(alert, animated: true)
        }
    }
    func isConnectedToInternet() -> Bool {
        let reachability = try? Reachability()
        return reachability?.connection != .unavailable
    }
    func showDeleteConfirmation(index:Int) {
            let alert = UIAlertController(
                title: "Delete Item",
                message: "Are you sure you want to delete this item?",
                preferredStyle: .alert
            )

            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)

            let deleteAction = UIAlertAction(title: "Delete", style: .destructive) { _ in
                self.presenter.removeLeagueFromFavorites(at: index)
            }

            alert.addAction(cancelAction)
            alert.addAction(deleteAction)

            present(alert, animated: true, completion: nil)
        }
}
