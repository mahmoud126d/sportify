//
//  FavoritesPresenter.swift
//  Sportify
//
//  Created by Aya Emam on 18/05/2025.
//
import Foundation

class FavoritesPresenter {
    
    let favoritesView: FavoritesViewProtocol
    let coreDataManager: CoreDataManager
    
    private var _favoriteLeagues: [FavoriteLeagueModel] = [] {
        didSet {
            favoritesView.displayFavoriteLeagues(leagues: self.favoriteLeagues)
        }
    }
    
    var favoriteLeagues: [FavoriteLeagueModel] {
        get {
            return _favoriteLeagues
        }
    }
    
    init(favoritesView: FavoritesViewProtocol, coreDataManager: CoreDataManager = CoreDataManager.shared) {
        self.favoritesView = favoritesView
        self.coreDataManager = coreDataManager
    }
    
    func fetchFavoriteLeagues() {
        let leagues = coreDataManager.getAllFavoriteLeagues()
        _favoriteLeagues = leagues
    }
    func removeLeagueFromFavorites(at index: Int) {
           let league = _favoriteLeagues[index]
           if coreDataManager.removeLeagueFromFavorites(leagueId: league.leagueId) {
               _favoriteLeagues.remove(at: index)
               favoritesView.leagueRemovedFromFavorites()
           } else {
               return
           }
       }
       
       func isLeagueInFavorites(leagueId: Int) -> Bool {
           return coreDataManager.isLeagueInFavorites(leagueId: leagueId)
       }
   }
