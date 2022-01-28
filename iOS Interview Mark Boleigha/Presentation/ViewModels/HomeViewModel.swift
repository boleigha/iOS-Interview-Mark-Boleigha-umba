//
//  HomeViewModel.swift
//  iOS Interview Mark Boleigha
//
//  Created by Mark Boleigha on 18/01/2022.
//  Copyright © 2022 Umba. All rights reserved.
//

import Foundation
import UIKit
import CoreData


class HomeViewModel: NSObject {
    
    var network: HTTP!
    var popular: [MovieResponse] = [MovieResponse]()
    var upcoming: [MovieResponse] = [MovieResponse]()
    var latest: Latest?
    var context: NSManagedObjectContext!
    
    var loading: Bool = false
    
    // Injected for testability
    override init() {
        super.init()
        network = HTTP.shared
        context = AppDelegate.shared.persistentContainer.viewContext
    }
    
    func loadLocal(callback: @escaping () -> Void) {
        if self.loading == true {
            return
        }
        
        self.loading = true
        
        let upcomingRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "MovieResponse")
        upcomingRequest.returnsObjectsAsFaults = false
        
        let popularRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "MovieResponse")
        popularRequest.returnsObjectsAsFaults = false

        do {
            let predicate = NSPredicate(format: "category == %@", "upcoming")
            upcomingRequest.predicate = predicate
            let upcomingResult = try context.fetch(upcomingRequest)
            for data in upcomingResult as! [NSManagedObject] {
                guard let movie = data as? MovieResponse else {
                    return
                }
                self.upcoming.appendDistinct(contentsOf: [movie]) { (old, new) -> Bool in
                    return old.original_title != new.original_title
                }
            }
                        
            let popularPredicate = NSPredicate(format: "category == %@", "popular")
            popularRequest.predicate = popularPredicate
            let popularResult = try context.fetch(popularRequest)
            
            for popular in popularResult as! [NSManagedObject] {
                guard let movie = popular as? MovieResponse else {
                    return
                }
                self.popular.appendDistinct(contentsOf: [movie]) { (old, new) -> Bool in
                    return old.original_title != new.original_title
                }
            }
            
//            let list = popularResult.map({ _ in MovieResponse(context: self.context)})
            
            self.loading = false
            callback()
        } catch {
            self.loading = false
            callback()
            print("Failed")
        }
    }
    
    func loadVideos(category: HomeCategories, completion: @escaping () -> Void) {
        switch category {
        case .latest:
            loadLatest { (movie) in
                guard let movie = movie else {
                    return // put retry here
                }
                self.latest = movie
                completion()
            }
        case .popular:
            loadPopular { (_ movie: MoviesResponse?) in
                guard let movie = movie else {
                    return
                }
                self.popular.appendDistinct(contentsOf: movie.results) { (old, new) -> Bool in
                    return old.id != new.id
                }
                completion()
            }
        case .upcoming:
            loadUpcoming { (_ movie: MoviesResponse?) in
                guard let movie = movie else {
                    return
                }
                self.upcoming.appendDistinct(contentsOf: movie.results) { (old, new) -> Bool in
                    return old.id != new.id
                }
                completion()
            }
        }
    }
    
    private func loadLatest(completion: @escaping (Latest?) -> Void) {
        let request = NetworkRequest(endpoint: .movies(.latest), method: .get, encoding: .url, body: [:])
        network.request(request) { (status, _ data: Latest?) in
            guard let latest = data else {
                completion(nil)
                return
            }
            switch status {
            case .success:
                DispatchQueue.main.async {
                    do {
                        try self.context.save()
                    } catch {
                        print("error: \(error)")
                    }
                    completion(latest)
                }
            case .failed(_):
                completion(nil)
            }
        }
    }
    
    private func loadPopular(completion: @escaping (MoviesResponse?) -> Void) {
        let request = NetworkRequest(endpoint: .movies(.popular), method: .get, encoding: .url, body: [:])
        network.request(request) { (status, _ response: MoviesResponse?) in
            guard let movies = response else {
                completion(nil)
                return
            }
            switch status {
            case .success:
                for movie in movies.results {
                    movie.category = "popular"
                }
                do {
                    try self.context.save()
                }catch {
                    print("error")
                }
                
                completion(movies)
            case .failed(_):
                completion(nil)
            }
        }
    }
    
    private func loadUpcoming(completion: @escaping (MoviesResponse?) -> Void) {
        let request = NetworkRequest(endpoint: .movies(.upcoming), method: .get, encoding: .url, body: [:])
        network.request(request) { (status, _ response: MoviesResponse?) in
            guard let movies = response else {
                completion(nil)
                return
            }
            switch status {
            case .success:
                for movie in movies.results {
                    movie.category = "upcoming"
                }
                do {
                    try self.context.save()
                }catch {
                    print("error")
                }
                completion(movies)
            case .failed(_):
                completion(nil)
            }
        }
    }
    
}


extension HomeViewModel: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView.tag == 0 {
            return popular.count
        } else {
            return upcoming.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView.tag == 0 {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PopularMoviesCell.identifier, for: indexPath) as? PopularMoviesCell else {
                return UICollectionViewCell()
            }
            
            if popular.count > 0 {
                cell.movie = popular[indexPath.row]
                cell.render()
            }
            return cell
        } else {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: UpcomingMoviesCell.identifier, for: indexPath) as? UpcomingMoviesCell else {
                return UICollectionViewCell()
            }
            
            if popular.count > 0 {
                cell.movie = popular[indexPath.row]
                cell.render()
            }
            return cell
        }
    }
}
