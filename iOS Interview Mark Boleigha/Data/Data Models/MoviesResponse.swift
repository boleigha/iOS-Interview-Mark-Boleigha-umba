//
//  MoviesResponse.swift
//  iOS Interview Mark Boleigha
//
//  Created by Mark Boleigha on 17/01/2022.
//  Copyright © 2022 Umba. All rights reserved.
//

import Foundation
import CoreData

enum DecoderConfigurationError: Error {
    case missingManagedObjectContext
    case noEntity
}

extension CodingUserInfoKey {
  static let managedObjectContext = CodingUserInfoKey(rawValue: "managedObjectContext")!
}

protocol Movie: Codable {
    var adult: Bool { get set}
    var original_title: String { get set }
    var overview: String { get set }
    var vote_average: Decimal { get set }
    var backdrop_path: String? { get set }
    var poster_path: String? { get set }
}


class MoviesResponse: NSManagedObject, Codable {
    var page: Int!
    var results: [MovieResponse]!
    var total_pages: Int! //1000,
    var total_results: Int! //20000
    
    enum CodingKeys: String, CodingKey {
        case page, results, total_pages, total_results
    }
    
    required convenience init(from decoder: Decoder) throws {
        guard let context = decoder.userInfo[CodingUserInfoKey.managedObjectContext] as? NSManagedObjectContext else {
          throw DecoderConfigurationError.missingManagedObjectContext
        }

        self.init(context: context)
        
        let values = try! decoder.container(keyedBy: CodingKeys.self)
        
        page = try values.decode(Int.self, forKey: .page)
        results = try values.decode([MovieResponse].self, forKey: .results)
        total_pages = try values.decode(Int.self, forKey: .total_pages)
        total_results = try values.decode(Int.self, forKey: .total_results)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(page, forKey: .page)
        try container.encode(results, forKey: .results)
        try container.encode(total_pages, forKey: .total_pages)
        try container.encode(total_results, forKey: .total_results)
    }
}

//@objc(MovieResponse)
class MovieResponse: NSManagedObject, Movie, Codable {
    @NSManaged dynamic var adult: Bool
    @NSManaged dynamic var backdrop_path: String? // "/cXwvuCQIaSLGlAR4tGEWZKITDGw.jpg",
    @NSManaged dynamic var genre_ids: [Int]!
    @NSManaged dynamic var id: Int //844398,
    @NSManaged dynamic var original_language: String //"en",
    @NSManaged dynamic var original_title: String //"Shattered",
    @NSManaged dynamic var poster_path: String? //"/bkMhuIYybOmw0rdIKPzsDs4n7ez.jpg",
    @NSManaged dynamic var vote_count: Int //7,
    @NSManaged dynamic var video: Bool //false,
    @NSManaged dynamic var vote_average: Decimal //7.4,
    @NSManaged dynamic var title: String! //"Shattered",
    @NSManaged dynamic var overview: String //"Chris, a wealthy divorcee, lives in a high-tech house of his own design in Montana. His life changes when he meets Sky, a mysterious young woman who draws him out of his shell and moves in after Chris is injured.",
    @NSManaged dynamic var release_date: String //"2022-01-14",
    @NSManaged dynamic var popularity: Float //77.972,
    @NSManaged dynamic var media_type: String? //"movie"
    
    enum CodingKeys: String, CodingKey {
        case adult, backdrop_path, genre_ids, id, original_language, original_title
        case poster_path, vote_count, video, vote_average, title, overview, release_date, popularity, media_type
    }
    
    required convenience init(from decoder: Decoder) throws {
        guard let context = decoder.userInfo[CodingUserInfoKey.managedObjectContext] as? NSManagedObjectContext else {
          throw DecoderConfigurationError.missingManagedObjectContext
        }
        
        guard let entity = NSEntityDescription.entity(forEntityName: "MovieResponse", in: context) else {
            throw DecoderConfigurationError.noEntity
        }

//        self.init(entity: entity, insertInto: context)
//        self.init(from: context)
        self.init(entity: entity, insertInto: context)
        
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
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(adult, forKey: .adult)
        try container.encode(backdrop_path, forKey: .backdrop_path)
        try container.encode(genre_ids, forKey: .genre_ids)
        try container.encode(id, forKey: .id)
        try container.encode(original_title, forKey: .original_title)
        try container.encode(original_language, forKey: .original_language)
    }
}

struct Genre: Codable {
    var id: Int //99,
    var name: String //"Documentary"
}
