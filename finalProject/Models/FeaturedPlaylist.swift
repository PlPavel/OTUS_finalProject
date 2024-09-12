//
//  FeaturedPlaylist.swift
//  finalProject
//
//  Created by Pavel Plyago on 17.08.2024.
//

import Foundation


struct FeaturedPlaylist: Codable {
    let playlists: Playlists
}

struct Playlists: Codable {
    let items: [ItemFeaturedPlaylist]
}

struct ItemFeaturedPlaylist: Codable {
    let description: String
    let images: [Image]
    let name: String
}

