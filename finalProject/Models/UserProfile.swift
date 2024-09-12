//
//  UserProfile.swift
//  finalProject
//
//  Created by Pavel Plyago on 13.08.2024.
//

import Foundation

struct UserProfile: Codable {
    let country: String
    let display_name: String
    let email: String
    let id: String
    let images: [Image]
    let product: String
}
