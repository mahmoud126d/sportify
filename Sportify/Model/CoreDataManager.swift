//
//  CoreDataManager.swift
//  Sportify
//
//  Created by Aya Emam on 18/05/2025.
//
import Foundation
import CoreData
import UIKit

class CoreDataManager {
    static let shared: CoreDataManager = CoreDataManager()
    init( ){ }
    
    lazy var persistentContainer: NSPersistentContainer = {
           let container = NSPersistentContainer(name: "Sportify")
           container.loadPersistentStores { (storeDescription, error) in
               if let error = error as NSError? {
                   fatalError(error.localizedDescription)
               }
           }
           return container
       }()
    var context: NSManagedObjectContext {
            return persistentContainer.viewContext
        }
        func saveContext() {
            if context.hasChanges {
                do {
                    try context.save()
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
    
    func saveLeagueToFavorites(league: LeagueDto, sport: String) -> Bool {
        guard let leagueId = league.leagueKey, !isLeagueInFavorites(leagueId: leagueId) else {
            return false
        }
        let favoriteLeague = NSEntityDescription.insertNewObject(forEntityName: "FavoriteLeague", into: context)
        favoriteLeague.setValue(leagueId, forKey: "leagueId")
        favoriteLeague.setValue(league.leagueName, forKey: "leagueName")
        favoriteLeague.setValue(league.leagueLogo, forKey: "leagueLogo")
        favoriteLeague.setValue(sport, forKey: "sport")
             
        saveContext()
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "FavoriteLeague")
        fetchRequest.predicate = NSPredicate(format: "leagueId == %d", leagueId)
        do {
            let results = try context.fetch(fetchRequest) as! [NSManagedObject]
            if let savedLeague = results.first {
                return true
            } else {
                return false
            }
        } catch {
            return false
        }
      }
    func removeLeagueFromFavorites(leagueId: Int) -> Bool {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "FavoriteLeague")
        fetchRequest.predicate = NSPredicate(format: "leagueId == %d", leagueId)
        do {
            let results = try context.fetch(fetchRequest) as! [NSManagedObject]
            if let leagueToDelete = results.first {
                context.delete(leagueToDelete)
                saveContext()
                return true
            }
            return false
        } catch {
            return false
        }
    }
    func isLeagueInFavorites(leagueId: Int) -> Bool {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "FavoriteLeague")
        fetchRequest.predicate = NSPredicate(format: "leagueId == %d", leagueId)
        do {
            let count = try context.count(for: fetchRequest)
            return count > 0
        } catch {
            return false
        }
       }
    func getAllFavoriteLeagues() -> [FavoriteLeagueModel] {
        let fetchRequest: NSFetchRequest<NSManagedObject> = NSFetchRequest(entityName: "FavoriteLeague")
        do {
            let results = try context.fetch(fetchRequest)
            return results.map { leagueObject in
                let leagueId = leagueObject.value(forKey: "leagueId") as? Int ?? 0
                let leagueName = leagueObject.value(forKey: "leagueName") as? String ?? ""
                let leagueLogo = leagueObject.value(forKey: "leagueLogo") as? String
                let sport = leagueObject.value(forKey: "sport") as? String ?? "football"
                return FavoriteLeagueModel(
                    leagueId: leagueId,
                    leagueName: leagueName,
                    leagueLogo: leagueLogo,
                    sport: sport)
            }
        } catch {
            return []
        }
    }
}
