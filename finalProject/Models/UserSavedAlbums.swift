//
//  UserSavedAlbums.swift
//  finalProject
//
//  Created by Pavel Plyago on 14.08.2024.
//

import Foundation

struct UserSavedAlbums: Codable {
    let items: [ItemAlbum]
}

struct ItemAlbum: Codable {
    let album: Album
}



//albums =     {
//        href = "https://api.spotify.com/v1/search?query=%D0%9E%D0%B1%D0%B0&type=album&locale=en-US%2Cen%3Bq%3D0.9&offset=0&limit=2";
//        items =         (
//                        {
//                "album_type" = album;
//                artists =                 (
//                                        {
//                        "external_urls" =                         {
//                            spotify = "https://open.spotify.com/artist/3KtiWEUyKC5lgHedcN6y6C";
//                        };
//                        href = "https://api.spotify.com/v1/artists/3KtiWEUyKC5lgHedcN6y6C";
//                        id = 3KtiWEUyKC5lgHedcN6y6C;
//                        name = MAYOT;
//                        type = artist;
//                        uri = "spotify:artist:3KtiWEUyKC5lgHedcN6y6C";
//                    }
//                );
//                "available_markets" =                 (
//
//                    IQ,
//                    LY,
//                    TJ,
//                    VE,
//                    ET,
//                    XK
//                );
//                "external_urls" =                 {
//                    spotify = "https://open.spotify.com/album/6GgEsUr9XO1MSdD3RUt3q9";
//                };
//                href = "https://api.spotify.com/v1/albums/6GgEsUr9XO1MSdD3RUt3q9";
//                id = 6GgEsUr9XO1MSdD3RUt3q9;
//                images =                 (
//                                        {
//                        height = 640;
//                        url = "https://i.scdn.co/image/ab67616d0000b2739f06bed6d691b494345d863a";
//                        width = 640;
//                    },
//                                        {
//                        height = 300;
//                        url = "https://i.scdn.co/image/ab67616d00001e029f06bed6d691b494345d863a";
//                        width = 300;
//                    },
//                                        {
//                        height = 64;
//                        url = "https://i.scdn.co/image/ab67616d000048519f06bed6d691b494345d863a";
//                        width = 64;
//                    }
//                );
//                name = "\U041e\U0411\U0410";
//                "release_date" = "2023-07-28";
//                "release_date_precision" = day;
//                "total_tracks" = 19;
//                type = album;
//                uri = "spotify:album:6GgEsUr9XO1MSdD3RUt3q9";
//            },
//                        {
//                "album_type" = single;
//                artists =                 (
//                                        {
//                        "external_urls" =                         {
//                            spotify = "https://open.spotify.com/artist/5VkHSxDQYSVNuWZUSXcPDQ";
//                        };
//                        href = "https://api.spotify.com/v1/artists/5VkHSxDQYSVNuWZUSXcPDQ";
//                        id = 5VkHSxDQYSVNuWZUSXcPDQ;
//                        name = GLOREE;
//                        type = artist;
//                        uri = "spotify:artist:5VkHSxDQYSVNuWZUSXcPDQ";
//                    }
//                );
//                "available_markets" =                 (
//
//                    ET,
//                    XK
//                );
//                "external_urls" =                 {
//                    spotify = "https://open.spotify.com/album/1T04BZ7UuTXqwjV9r4EGj5";
//                };
//                href = "https://api.spotify.com/v1/albums/1T04BZ7UuTXqwjV9r4EGj5";
//                id = 1T04BZ7UuTXqwjV9r4EGj5;
//                images =                 (
//                                        {
//                        height = 640;
//                        url = "https://i.scdn.co/image/ab67616d0000b273a2fe610a6e4f562ea4b5517f";
//                        width = 640;
//                    },
//                                        {
//                        height = 300;
//                        url = "https://i.scdn.co/image/ab67616d00001e02a2fe610a6e4f562ea4b5517f";
//                        width = 300;
//                    },
//                                        {
//                        height = 64;
//                        url = "https://i.scdn.co/image/ab67616d00004851a2fe610a6e4f562ea4b5517f";
//                        width = 64;
//                    }
//                );
//                name = "\U041e\U0431\U0430";
//                "release_date" = "2024-02-15";
//                "release_date_precision" = day;
//                "total_tracks" = 1;
//                type = album;
//                uri = "spotify:album:1T04BZ7UuTXqwjV9r4EGj5";
//            }
//        );
//        limit = 2;
//        next = "https://api.spotify.com/v1/search?query=%D0%9E%D0%B1%D0%B0&type=album&locale=en-US%2Cen%3Bq%3D0.9&offset=2&limit=2";
//        offset = 0;
//        previous = "<null>";
//        total = 102;
//    };
//    artists =     {
