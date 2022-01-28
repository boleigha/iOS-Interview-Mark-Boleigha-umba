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
    var id: Int { get set }
    var adult: Bool { get set}
    var original_title: String { get set }
    var overview: String { get set }
    var vote_average: Double { get set }
    var backdrop_path: String? { get set }
    var poster_path: String? { get set }
    var category: String? { get set }
}


struct MoviesResponse: Codable {
    var page: Int!
    var results: [MovieResponse]!
    var total_pages: Int! //1000,
    var total_results: Int! //20000
    
    
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
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(page, forKey: .page)
        try container.encode(results, forKey: .results)
        try container.encode(total_pages, forKey: .total_pages)
        try container.encode(total_results, forKey: .total_results)
    }
}

class MovieResponse: NSManagedObject, Codable, Movie {
    
    @NSManaged dynamic var id: Int
    @NSManaged dynamic var adult: Bool
    @NSManaged dynamic var original_title: String
    @NSManaged dynamic var overview: String
    @NSManaged dynamic var backdrop_path: String?
    @NSManaged dynamic var poster_path: String?
    @NSManaged dynamic var vote_average: Double
    @NSManaged dynamic var category: String?
    
    enum CodingKeys: String, CodingKey {
        case adult, backdrop_path, id, original_language, original_title, category
        case poster_path, vote_count, video, vote_average, title, overview, release_date, popularity, media_type
    }
    
    required convenience init(from decoder: Decoder) throws {
        
        guard let context = decoder.userInfo[CodingUserInfoKey.managedObjectContext] as? NSManagedObjectContext else {
          throw DecoderConfigurationError.missingManagedObjectContext
        }
        
        guard let entity = NSEntityDescription.entity(forEntityName: "MovieResponse", in: context) else {
            throw DecoderConfigurationError.noEntity
        }

        self.init(entity: entity, insertInto: context)
        
        let values = try! decoder.container(keyedBy: CodingKeys.self)
        print("values: \(values)")
        id = try values.decode(Int.self, forKey: .id)
        adult = try values.decode(Bool.self, forKey: .adult)
        original_title = try values.decode(String.self, forKey: .original_title)
        poster_path = try values.decodeIfPresent(String.self, forKey: .poster_path)
        backdrop_path = try values.decodeIfPresent(String.self, forKey: .backdrop_path)
        overview = try values.decode(String.self, forKey: .overview)
        vote_average = try values.decode(Double.self, forKey: .vote_average)
        category = try values.decodeIfPresent(String.self, forKey: .category)
        
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(adult, forKey: .adult)
        try container.encode(backdrop_path, forKey: .backdrop_path)
        try container.encode(id, forKey: .id)
        try container.encode(original_title, forKey: .original_title)
        try container.encode(poster_path, forKey: .poster_path)
        try container.encode(overview, forKey: .overview)
        try container.encode(vote_average, forKey: .vote_average)
        try container.encodeIfPresent(category, forKey: .category)
    }
//    
//    @nonobjc public class func fetchRequest() -> NSFetchRequest<MovieResponse> {
//        return NSFetchRequest<MovieResponse>(entityName: "MovieResponse")
//    }
}

struct Genre: Codable {
    var id: Int //99,
    var name: String //"Documentary"
}
