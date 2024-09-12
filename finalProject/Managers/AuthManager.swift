//
//  AuthManager.swift
//  finalProject
//
//  Created by Pavel Plyago on 09.08.2024.
//

import Foundation

final class AuthManager {
    static let shared = AuthManager()
    
    struct Constants {
        static let clientID = "8cad058af3e34f1b8dc2dd4fbb1e23f7"
        static let clientSecret = "666e4815de2e4c21879ef5c7d84873cd"
        static let redirectURI = "https://genius.com"
        static let tokenAPI = "https://accounts.spotify.com/api/token"
        static let scopes = "user-read-private%20playlist-modify-public%20playlist-read-private%20playlist-modify-private%20user-follow-read%20user-library-modify%20user-library-read%20user-read-email"
    }
    

    public var signInURL: URL? = {
        let base = "https://accounts.spotify.com/authorize"
        
        let url = "\(base)?response_type=code&client_id=\(Constants.clientID)&redirect_uri=\(Constants.redirectURI)&scope=\(Constants.scopes)&show_dialog=TRUE"
        
        return URL(string: url)
    }()
    
    private init() {}
    
    public var isSingIn: Bool {
        return access_token != nil
    }
    
    private var access_token: String? {
        return UserDefaults.standard.string(forKey: "access_token")
    }
    
    private var refresh_token: String? {
        return UserDefaults.standard.string(forKey: "refresh_token")
    }
    
    private var tokenExpirationDate: Date? {
        return UserDefaults.standard.object(forKey: "expiration") as? Date
    }
    

    private var shouldRefreshToken: Bool {
        guard let expirationDate = self.tokenExpirationDate else {
            return false
        }
        
        let currentDate = Date()
        let fiveMinutes: TimeInterval = 300
        return currentDate.addingTimeInterval(fiveMinutes) >= expirationDate
    }
    

    public func exchageCodeForToken(code: String, completion: @escaping (Bool) -> Void){
        guard let url = URL(string: Constants.tokenAPI) else {
            return
        }
        
        var components = URLComponents()
        components.queryItems = [
            URLQueryItem(name: "grant_type",
                         value: "authorization_code"),
            URLQueryItem(name: "code",
                         value: code),
            URLQueryItem(name: "redirect_uri",
                         value: Constants.redirectURI)
        ]
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpBody = components.query?.data(using: .utf8)
        
        let basicToken = Constants.clientID + ":" + Constants.clientSecret
        let data = basicToken.data(using: .utf8)
        guard let base64String = data?.base64EncodedString() else {
            print("Failor to get base64")
            completion(false)
            return
        }
        request.setValue("Basic \(base64String)", forHTTPHeaderField: "Authorization")
        
        
        let task = URLSession.shared.dataTask(with: request) { [weak self] data, _, error in
            guard let data = data, error == nil else {
                return
            }
            do {
                let result = try JSONDecoder().decode(AuthResponse.self, from: data)
                self?.cacheToken(result: result)
                completion(true)
            }
            catch {
                completion(false)
            }
        }
        task.resume()
    }
    

    public func withValidToken(completion: @escaping (String) -> Void) {
        
        if shouldRefreshToken {
            refreshIfNeeded {[weak self] success in
                if let token = self?.access_token, success {
                    completion(token)
                }
            }
        }
        else if let token = access_token {
            completion(token)
        }
    }
    

    public func refreshIfNeeded(completion: @escaping ((Bool) -> Void)) {
        guard shouldRefreshToken else {
            completion(true)
            return
        }
        
        guard let refreshToken = self.refresh_token else {
            return
        }
        
        
        guard let url = URL(string: Constants.tokenAPI) else {
            return
        }
        
        var components = URLComponents()
        components.queryItems = [
            URLQueryItem(name: "grant_type",
                         value: "refresh_token"),
            URLQueryItem(name: "refresh_token",
                         value: refreshToken)
        ]
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpBody = components.query?.data(using: .utf8)
        
        let basicToken = Constants.clientID+":"+Constants.clientSecret
        let data = basicToken.data(using: .utf8)
        guard let base64String = data?.base64EncodedString() else {
            print("Failor to get base64")
            completion(false)
            return
        }
        request.setValue("Basic \(base64String)", forHTTPHeaderField: "Authorization")
        
        let task = URLSession.shared.dataTask(with: request) {[weak self] data, _, error in
            guard let data = data, error == nil else {
                completion(false)
                return
            }
            do{
                let result = try JSONDecoder().decode(AuthResponse.self, from: data)
                self?.cacheToken(result: result)
                completion(true)
            }
            catch {
                print(error.localizedDescription)
                completion(false)
            }
        }
        task.resume()
    }
    

    public func cacheToken(result: AuthResponse) {
        UserDefaults.standard.setValue(result.access_token, forKey: "access_token")
        if let refresh_token = result.refresh_token {
            UserDefaults.standard.setValue(refresh_token, forKey: "refresh_token")
        }
        UserDefaults.standard.setValue(Date().addingTimeInterval(TimeInterval(result.expires_in)), forKey: "expiration")
    }
}
