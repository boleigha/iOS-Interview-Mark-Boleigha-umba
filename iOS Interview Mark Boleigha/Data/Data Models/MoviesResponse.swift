//
//  MoviesResponse.swift
//  iOS Interview Mark Boleigha
//
//  Created by Mark Boleigha on 17/01/2022.
//  Copyright © 2022 Umba. All rights reserved.
//

import Foundation

struct MoviesResponse: Codable {
    var page: Int
    var results: [MovieResponse]
    var total_pages: Int64 //1000,
    var total_results: Int64 //20000
}

struct MovieResponse: Codable {
    var adult: Bool //false,
    var backdrop_path: String // "/cXwvuCQIaSLGlAR4tGEWZKITDGw.jpg",
    var genre_ids: [Int]
    var id: Int64 //844398,
    var original_language: String //"en",
    var original_title: String //"Shattered",
    var poster_path: String //"/bkMhuIYybOmw0rdIKPzsDs4n7ez.jpg",
    var vote_count: Int //7,
    var video: Bool //false,
    var vote_average: Decimal //7.4,
    var title: String //"Shattered",
    var overview: String //"Chris, a wealthy divorcee, lives in a high-tech house of his own design in Montana. His life changes when he meets Sky, a mysterious young woman who draws him out of his shell and moves in after Chris is injured.",
    var release_date: String //"2022-01-14",
    var popularity: Float //77.972,
    var media_type: String //"movie"
}
