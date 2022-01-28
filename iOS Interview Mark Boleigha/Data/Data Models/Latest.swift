//
//  Latest.swift
//  iOS Interview Mark Boleigha
//
//  Created by Mark Boleigha on 27/01/2022.
//  Copyright © 2022 Umba. All rights reserved.
//

import Foundation
import CoreData

class Latest: NSManagedObject, Codable, Movie {
    
    @NSManaged dynamic var adult: Bool
    @NSManaged dynamic var backdrop_path: String?
    @NSManaged dynamic var id: Int
    @NSManaged dynamic var original_title: String
    @NSManaged dynamic var overview: String
    @NSManaged dynamic var popularity: Float
    @NSManaged dynamic var poster_path: String?
    @NSManaged dynamic var vote_average: Double
    @NSManaged dynamic var vote_count: Int
    @NSManaged dynamic var category: String?
    
    enum CodingKeys: String, CodingKey {
        case adult, backdrop_path, id, category
        case original_title, overview, popularity, poster_path, vote_average, vote_count
    }
    
    required convenience init(from decoder: Decoder) throws {
        guard let context = decoder.userInfo[CodingUserInfoKey.managedObjectContext] as? NSManagedObjectContext else {
          throw DecoderConfigurationError.missingManagedObjectContext
        }
        
        guard let entity = NSEntityDescription.entity(forEntityName: "LatestMovie", in: context) else {
            throw DecoderConfigurationError.noEntity
        }
        
        self.init(entity: entity, insertInto: context)
        
        let values = try! decoder.container(keyedBy: CodingKeys.self)
        adult = try values.decode(Bool.self, forKey: .adult)
        backdrop_path = try values.decodeIfPresent(String.self, forKey: .backdrop_path)
        id = try values.decode(Int.self, forKey: .id)
        overview = try values.decode(String.self, forKey: .overview)
        popularity = try values.decode(Float.self, forKey: .popularity)
        poster_path = try values.decodeIfPresent(String.self, forKey: .poster_path)
        vote_average = try values.decode(Double.self, forKey: .vote_average)
        vote_count = try values.decode(Int.self, forKey: .vote_count)
        category = try values.decodeIfPresent(String.self, forKey: .category)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(adult, forKey: .adult)
        try container.encode(backdrop_path, forKey: .backdrop_path)
        try container.encode(id, forKey: .id)
        try container.encode(overview, forKey: .overview)
        try container.encode(popularity, forKey: .popularity)
        try container.encode(poster_path, forKey: .poster_path)
        try container.encode(vote_average, forKey: .vote_average)
        try container.encode(vote_count, forKey: .vote_count)
        try container.encodeIfPresent(category, forKey: .category)
    }
}
