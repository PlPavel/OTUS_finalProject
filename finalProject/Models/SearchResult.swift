//
//  SearchResult.swift
//  finalProject
//
//  Created by Pavel Plyago on 02.09.2024.
//

import Foundation

enum SearchResult {
    case album(model: Album)
    case artist(model: ItemArtist)
    case track(model: Track)
}
