//
//  Artist.swift
//  finalProject
//
//  Created by Pavel Plyago on 24.08.2024.
//

import Foundation

struct Artists: Codable {
    let items: [ItemArtist]
}

struct ItemArtist: Codable {
    let images: [Image]
    let name: String
}
