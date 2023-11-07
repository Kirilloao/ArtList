//
//  NetworkManager.swift
//  ArtList
//
//  Created by Kirill Taraturin on 07.11.2023.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingError
}

final class NetworkManager {
    static let shared = NetworkManager()
    
    private init() {}
    
    func fetch(with url: String, completion: @escaping(Result<Artist, NetworkError>) -> Void) {
        guard let url = URL(string: url) else {
            completion(.failure(.invalidURL))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else {
                completion(.failure(.noData))
                return
            }
            
            do {
                let artist = try JSONDecoder().decode(Artist.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(artist))
                }
            } catch {
                completion(.failure(.decodingError))
            }
        }.resume()
    }
}

enum Links: String {
case api = "https://file.notion.so/f/f/b8bbfa88-ab7c-464e-8c0e-1c109af93066/8c0c0258-c23a-4229-ae76-b515867cc1d8/artists.json?id=65f3a8fb-a15e-48f4-a7ed-f75be1b2f4fb&table=block&spaceId=b8bbfa88-ab7c-464e-8c0e-1c109af93066&expirationTimestamp=1699444800000&signature=xaGGoF8RNn6rz9S-MWhWh7Omn-RnJ6UU0p3UOQ6-w2c&downloadName=artists.json"
}
