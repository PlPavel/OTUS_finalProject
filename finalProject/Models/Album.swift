//
//  Album.swift
//  finalProject
//
//  Created by Pavel Plyago on 24.08.2024.
//

import Foundation

struct Album: Codable {
    let artists: [Artist]
    let images: [Image]
    let name: String
}

struct Artist: Codable {
    let id: String
    let name: String
}
