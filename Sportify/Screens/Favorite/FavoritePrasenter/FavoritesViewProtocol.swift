//
//  FavoritesViewProtocol.swift
//  Sportify
//
//  Created by Aya Emam on 18/05/2025.
//
import Foundation

protocol FavoritesViewProtocol {
    func displayFavoriteLeagues(leagues: [FavoriteLeagueModel])
    func leagueRemovedFromFavorites()
}
