//
//  APICaller.swift
//  finalProject
//
//  Created by Pavel Plyago on 13.08.2024.
//

import Foundation

class APICaller {
    
    static let shared = APICaller()
    
    private init() {}
    
    struct Constants {
        static let baseURL = "https://api.spotify.com/v1"
    }
    
    enum ErrorHandler: Error {
        case failedToGetData
    }
    

    func getCurrentUserProfile(completion: @escaping (Result<UserProfile, Error>) -> Void) {
        createRequest(with: URL(string: Constants.baseURL + "/me"), method: .GET) { request in
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                guard let data = data, error == nil else {
                    completion(.failure(ErrorHandler.failedToGetData))
                    return
                }
                do {
                    let result = try JSONDecoder().decode(UserProfile.self, from: data)
                    completion(.success(result))
                }
                catch {
                    print(error.localizedDescription)
                    completion(.failure(error))
                }
            }
            task.resume()
        }
    }

    func getSavedUserAlbum(completion: @escaping (Result<UserSavedAlbums, Error>)->Void) {
        createRequest(with: URL(string: Constants.baseURL + "/me/albums?limit=9"), method: .GET) { request in
            let task = URLSession.shared.dataTask(with: request) { data, _, error in
                guard let data = data, error == nil else {
                    completion(.failure(ErrorHandler.failedToGetData))
                    return
                }
                
                do {
                    let result = try JSONDecoder().decode(UserSavedAlbums.self, from: data)
                    completion(.success(result))
                }
                catch {
                    print(error.localizedDescription)
                    completion(.failure(error))
                }
            }
            task.resume()
        }
    }
    

    func getFollowedArtists(completion: @escaping (Result<FollowedArtists, Error>) -> Void) {
        createRequest(with: URL(string: Constants.baseURL + "/me/following?type=artist&limit=10"), method: .GET) { request in
            let task = URLSession.shared.dataTask(with: request) { data, _, error in
                guard let data = data, error == nil else {
                    completion(.failure(ErrorHandler.failedToGetData))
                    return
                }
                
                do {
                    let result = try JSONDecoder().decode(FollowedArtists.self, from: data)
                    completion(.success(result))
                }
                catch {
                    print(error.localizedDescription)
                    completion(.failure(error))
                }
            }
            task.resume()
        }
    }
    
    func getFeaturedPlaylist(completion: @escaping (Result<FeaturedPlaylist, Error>) -> Void) {
        createRequest(with: URL(string: Constants.baseURL + "/browse/featured-playlists?locale=ru&limit=10"),
                      method: .GET) { request in
            let task = URLSession.shared.dataTask(with: request) { data, _, error in
                guard let data = data, error == nil else {
                    completion(.failure(ErrorHandler.failedToGetData))
                    return
                }
                
                do {
                    let result = try JSONDecoder().decode(FeaturedPlaylist.self, from: data)
                    completion(.success(result))
                }
                catch {
                    print(error.localizedDescription)
                    completion(.failure(error))
                }
            }
            task.resume()
        }
    }
    
    func searchForItem(query: String, completion: @escaping (Result<Search, Error>) -> Void){
        createRequest(with: URL(string: Constants.baseURL + "/search?type=album,artist,track&limit=4&q=\(query)"),
                      method: .GET) { request in
            let task = URLSession.shared.dataTask(with: request) { data, _, error in
                guard let data = data, error == nil else {
                    completion(.failure(ErrorHandler.failedToGetData))
                    return
                }
                
                do {
                    let result = try JSONDecoder().decode(Search.self, from: data)
                    
                    completion(.success(result))
                }
                catch {
                    completion(.failure(error))
                    print(error.localizedDescription)
                }
            }
            task.resume()
        }
    }
    
    enum HTTPMethod: String {
        case POST
        case GET
    }
    

    private func createRequest(with url: URL?,
                       method: HTTPMethod,
                       completion: @escaping (URLRequest) -> Void){
        AuthManager.shared.withValidToken { token in
            guard let apiURL = url else {
                return
            }
            
            var request = URLRequest(url: apiURL)
            request.httpMethod = method.rawValue
            request.setValue("Bearer \(token)",
                             forHTTPHeaderField: "Authorization")
            completion(request)
        }
    }
    
}
