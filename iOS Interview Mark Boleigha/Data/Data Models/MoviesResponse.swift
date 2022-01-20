//
//  MoviesResponse.swift
//  iOS Interview Mark Boleigha
//
//  Created by Mark Boleigha on 17/01/2022.
//  Copyright © 2022 Umba. All rights reserved.
//

import Foundation

protocol Movie: Codable {
    var adult: Bool { get set}
    var original_title: String { get set }
    var overview: String { get set }
    var vote_average: Decimal { get set }
    var backdrop_path: String? { get set }
    var poster_path: String? { get set }
}


struct MoviesResponse: Codable {
    var page: Int
    var results: [MovieResponse]
    var total_pages: Int //1000,
    var total_results: Int //20000
    
    enum CodingKeys: String, CodingKey {
        case page, results, total_pages, total_results
    }
    
    init(from decoder: Decoder) throws {
        let values = try! decoder.container(keyedBy: CodingKeys.self)
        page = try values.decode(Int.self, forKey: .page)
        results = try values.decode([MovieResponse].self, forKey: .results)
        total_pages = try values.decode(Int.self, forKey: .total_pages)
        total_results = try values.decode(Int.self, forKey: .total_results)
    }
}

struct MovieResponse: Movie, Codable {
    var adult: Bool //false,
    var backdrop_path: String? // "/cXwvuCQIaSLGlAR4tGEWZKITDGw.jpg",
    var genre_ids: [Int]
    var id: Int //844398,
    var original_language: String //"en",
    var original_title: String //"Shattered",
    var poster_path: String? //"/bkMhuIYybOmw0rdIKPzsDs4n7ez.jpg",
    var vote_count: Int //7,
    var video: Bool //false,
    var vote_average: Decimal //7.4,
    var title: String //"Shattered",
    var overview: String //"Chris, a wealthy divorcee, lives in a high-tech house of his own design in Montana. His life changes when he meets Sky, a mysterious young woman who draws him out of his shell and moves in after Chris is injured.",
    var release_date: String //"2022-01-14",
    var popularity: Float //77.972,
    var media_type: String? //"movie"
    
    enum CodingKeys: String, CodingKey {
        case adult, backdrop_path, genre_ids, id, original_language, original_title
        case poster_path, vote_count, video, vote_average, title, overview, release_date, popularity, media_type
    }
    
    init(from decoder: Decoder) throws {
        let values = try! decoder.container(keyedBy: CodingKeys.self)
        
        adult = try values.decode(Bool.self, forKey: .adult)
        backdrop_path = try values.decodeIfPresent(String.self, forKey: .backdrop_path)
        genre_ids = try values.decode([Int].self, forKey: .genre_ids)
        id = try values.decode(Int.self, forKey: .id)
        original_title = try values.decode(String.self, forKey: .original_title)
        original_language = try values.decode(String.self, forKey: .original_language)
        poster_path = try values.decodeIfPresent(String.self, forKey: .poster_path)
        vote_count = try values.decode(Int.self, forKey: .vote_count)
        vote_average = try values.decode(Decimal.self, forKey: .vote_average)
        title = try values.decode(String.self, forKey: .title)
        overview = try values.decode(String.self, forKey: .overview)
        release_date = try values.decode(String.self, forKey: .release_date)
        popularity = try values.decode(Float.self, forKey: .popularity)
        media_type = try values.decodeIfPresent(String.self, forKey: .media_type)
        video = try values.decode(Bool.self, forKey: .video)
    }
}

struct LatestMovieResponse: Movie, Codable {
    
    var adult: Bool //false,
    var backdrop_path: String? // null,
    var budget: Decimal //0,
    var genres: [Genre]
//    var homepage: String? //"",
    var id: Int64 //413323,
//    var imdb_id: String //"tt5852644",
    var original_language: String //"en",
    var original_title: String //"Deadpool: From Comics to Screen... to Screen",
    var overview: String // "This documentary divided into five segments examines the source and its path to the movies, backstory, special effects story/character areas, cast and performances. It includes notes from Reynolds, Liefeld, Miller, Wernick, Reese, executive producers Aditya Sood and Stan Lee, co-creator/comics writer Fabian Nicieza, producer Simon Kinberg, comics writer Joe Kelly, specialty costume designer Russell Shinkle, makeup designer Bill Corso, production designer Sean Haworth, director of photography Ken Seng, executive producer/unit production manager John J. Kelly, previs supervisor Franck Balson, stunt coordinator Philip J. Silvera, visual effects supervisors Pauline Duvall and Jonathan Rothbart, visual effects producer Annemarie Griggs, 2nd unit director/stunt coordinator Robert Alonzo, special effects coordinator Alex Burdett, utility stunts Regis Harrington, composer Tom Holkenberg, and actors Morena Baccarin, TJ Miller, Brianna Hildebrand, Leslie Uggams, Ed Skrein, and Gina Carano.",
    var popularity: Float //0,
    var poster_path: String? //"/chV0avy5ogIB2PMTInT4KpHDzwj.jpg",
    var title: String //"Deadpool: From Comics to Screen... to Screen",
    var video: Bool //false,
    var vote_average: Decimal
    var vote_count: Int //0
}

struct Genre: Codable {
    var id: Int //99,
    var name: String //"Documentary"
}
