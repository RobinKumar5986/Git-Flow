//
//  NetworkManager.swift
//  Git Follow
//
//  Created by iOS Dev on 26/12/25.
//

import Foundation
/**
 * its a singleton class
 * can be accessed from all anywhre in the app.
 */
class NetworkManager {
    static let shared = NetworkManager()
    let baseUrl = "https://api.github.com"
    
    private init() {}
    
    func getFollowers(
        for username: String,
        page: Int,
        completion: @escaping (Result<[Follower], GFError>) -> Void
    ) {
        let endpoint = baseUrl + "/users/\(username)/followers?page=\(page)" //can also add how many followers do we want to get using ?per_page = <value (int)>
        guard let url = URL(string: endpoint) else {
            completion(.failure(.invalidRequest))
            return
        }
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let _ = error {
                completion(.failure(.completionError))
                return
            } 
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completion(.failure(.fetchError))
                return
            }
            
            guard let data = data else {
                completion(.failure(.nullDataError))
                return
            }
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                
                let flowers: [Follower] = try decoder.decode([Follower].self, from: data)
                completion(.success(flowers))
            }catch {
                completion(.failure(.parsingError))
            }
            
        }
        task.resume()
    }
}
