//
//  Latest.swift
//  iOS Interview Mark Boleigha
//
//  Created by Mark Boleigha on 27/01/2022.
//  Copyright © 2022 Umba. All rights reserved.
//

import Foundation
import CoreData

class Latest: NSManagedObject, Movie, Codable {

    @NSManaged dynamic var adult: Bool //false,
    @NSManaged dynamic var backdrop_path: String? // null,
    @NSManaged @objc(budget) var budget: Decimal //0,
//    @NSManaged dynamic var genres: [Genre]
    //    var homepage: String? //"",
    @NSManaged dynamic var id: Int64 //413323,
    //    var imdb_id: String //"tt5852644",
    @NSManaged dynamic var original_language: String //"en",
    @NSManaged dynamic var original_title: String //"Deadpool: From Comics to Screen... to Screen",
    @NSManaged dynamic var overview: String
    @NSManaged dynamic var popularity: Float
    @NSManaged dynamic var poster_path: String? //"/chV0avy5ogIB2PMTInT4KpHDzwj.jpg",
    @NSManaged dynamic var title: String //"Deadpool: From Comics to Screen... to Screen",
    @NSManaged @objc(video) var video: Bool
    @NSManaged @objc(vote_average) var vote_average: Decimal
    @NSManaged @objc(vote_count) var vote_count: Int //0
    
    enum CodingKeys: String, CodingKey {
        case adult, backdrop_path, budget, id, original_language
        case original_title, overview, popularity, poster_path, title, video, vote_average, vote_count
    }
    
    required convenience init(from decoder: Decoder) throws {
        guard let context = decoder.userInfo[CodingUserInfoKey.managedObjectContext] as? NSManagedObjectContext else {
          throw DecoderConfigurationError.missingManagedObjectContext
        }
        
        guard let entity = NSEntityDescription.entity(forEntityName: "Latest", in: context) else {
            throw DecoderConfigurationError.noEntity
        }
        
        self.init(entity: entity, insertInto: context)
        
        let values = try! decoder.container(keyedBy: CodingKeys.self)
        adult = try values.decode(Bool.self, forKey: .adult)
        backdrop_path = try values.decodeIfPresent(String.self, forKey: .backdrop_path)
        budget = try values.decode(Decimal.self, forKey: .budget)
//        genres = try values.decode([Genre].self, forKey: .genres)
        id = try values.decode(Int64.self, forKey: .id)
        original_language = try values.decode(String.self, forKey: .original_language)
        overview = try values.decode(String.self, forKey: .overview)
        popularity = try values.decode(Float.self, forKey: .popularity)
        poster_path = try values.decodeIfPresent(String.self, forKey: .poster_path)
        title = try values.decode(String.self, forKey: .title)
        video = try values.decode(Bool.self, forKey: .video)
        vote_average = try values.decode(Decimal.self, forKey: .vote_average)
        vote_count = try values.decode(Int.self, forKey: .vote_count)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(adult, forKey: .adult)
        try container.encode(backdrop_path, forKey: .backdrop_path)
        try container.encode(budget, forKey: .budget)
//        try container.encode(genres, forKey: .genres)
        try container.encode(id, forKey: .id)
        try container.encode(original_language, forKey: .original_language)
        try container.encode(overview, forKey: .overview)
        try container.encode(popularity, forKey: .popularity)
        try container.encode(poster_path, forKey: .poster_path)
        try container.encode(title, forKey: .title)
        try container.encode(video, forKey: .video)
        try container.encode(vote_average, forKey: .vote_average)
        try container.encode(vote_count, forKey: .vote_count)
    }
}
