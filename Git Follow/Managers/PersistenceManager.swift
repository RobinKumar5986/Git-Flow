//
//  PersistenceManager.swift
//  Git Follow
//
//  Created by iOS Dev on 05/03/26.
//

import Foundation

enum PersistenceActionType {
    case add
    case remove
}

enum PersistenceManager {
    static private let defaults = UserDefaults.standard
    enum Keys {
        static let favorites = "favorites"
    }
    
    static func update(favorite: Follower, actionType: PersistenceActionType,completion: @escaping(GFError?) -> Void){
        retriveFavorites(completion: { result in
            switch result {
            case .success(let favorites):
                var retrivedFavorites = favorites
                switch actionType {
                case .add:
                    if retrivedFavorites.contains(favorite){
                        completion(.alreadyExist)
                        return
                    }
                    retrivedFavorites.append(favorite)
                case .remove:
                    retrivedFavorites.removeAll(where: { $0.login == favorite.login })
                }
                completion(save(favorites: retrivedFavorites))
            case .failure(let error):
                completion(error)
            }
        })
    }
    
    static func retriveFavorites(completion: @escaping(Result<[Follower],GFError>) -> Void ){
        guard let favoritesData = defaults.object(forKey: Keys.favorites) as? Data else {
            completion(.success([]))
            return
        }
        do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            
            let favorites: [Follower] = try decoder.decode([Follower].self, from: favoritesData )
            completion(.success(favorites))
        }catch {
            completion(.failure(.unableToFavorite))
        }
    }
    
    static func save(favorites: [Follower]) -> GFError? {
        do  {
            let encoder = JSONEncoder()
            let encodedFavorites = try encoder.encode(favorites)
            defaults.set(encodedFavorites, forKey: Keys.favorites)
            return nil
        }catch {
            return .unableToFavorite
        }
    }
}
