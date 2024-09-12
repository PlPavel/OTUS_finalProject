//
//  Search.swift
//  finalProject
//
//  Created by Pavel Plyago on 23.08.2024.
//

import Foundation

struct Search: Codable {
    let albums: SearchAlbums
    let artists: Artists
    let tracks: SearchTracks
}

struct SearchAlbums: Codable {
    let items: [Album]
}

struct SearchArtists: Codable {
    let items: [ItemArtist]
}

struct SearchTracks: Codable {
    let items: [Track]
}

struct Track: Codable {
    let album: Album
    let artists: [Artist]
}
