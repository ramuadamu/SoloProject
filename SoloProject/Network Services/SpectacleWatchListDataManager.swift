//
//  SpectacleWatchListDataManager.swift
//  SoloProject
//
//  Created by Ramu on 3/7/19.
//  Copyright © 2019 Ramu. All rights reserved.
//

import Foundation

final class SpectacleWatchListDataManager {
    private init() {}
    
private static let filename = "FavoriteSpectacles.plist"
    static private var favoriteSpectacles = [FavoriteSpectacles]()
    
    static public func fetchFavoriteSpectacleFromDocumentDirectory() -> [FavoriteSpectacles] {
        var favoriteSpectacle = [FavoriteSpectacles]()
        let path = DataPersistenceManager.filenameFromDoucmentsDirectory(filename: filename).path
        print(path)
        if FileManager.default.fileExists(atPath: path) {
            if let data = FileManager.default.contents(atPath: path) {
            do {
             let foundSpectacle = try PropertyListDecoder().decode([FavoriteSpectacles].self, from: data)
               favoriteSpectacle = foundSpectacle
            } catch {
                print("property list encoding error: \(error)")
                }
            } else {
                print("data is nil")
            }
    }
        return favoriteSpectacle
}
    static public func saveToDocumentDirectory(newFavoriteSpectacle: FavoriteSpectacles) -> (success: Bool, error: Error?) {
        var favoriteSpectacle = fetchFavoriteSpectacleFromDocumentDirectory()
        favoriteSpectacle.append(newFavoriteSpectacle)
        let path = DataPersistenceManager.filenameFromDoucmentsDirectory(filename: filename)
        do {
            let data = try PropertyListEncoder().encode(favoriteSpectacle)
            try data.write(to: path, options: Data.WritingOptions.atomic)
        } catch {
            print("property list encoding error: \(error)")
            return (false, error)
        }
        return (true, nil)
    }
    
    static func delete(favoriteSpectacle: FavoriteSpectacles, atIndex index: Int) {
        var favoriteSpectacle = fetchFavoriteSpectacleFromDocumentDirectory()
        favoriteSpectacle.remove(at: index)
        
        let path = DataPersistenceManager.filenameFromDoucmentsDirectory(filename: filename)
        do {
            let data = try PropertyListEncoder().encode(favoriteSpectacle)
            try data.write(to: path, options: Data.WritingOptions.atomic)
        } catch {
            print("property list encoding error: \(error)")
        }
    }
}
