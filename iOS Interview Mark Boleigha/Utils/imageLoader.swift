//
//  imageLoader.swift
//  iOS Interview Mark Boleigha
//
//  Created by Mark Boleigha on 19/01/2022.
//  Copyright © 2022 Umba. All rights reserved.
//

import Foundation
import Alamofire

class ImageLoader {
    
    static func loadImageData(urlString: String, _ completion: @escaping (UIImage?) -> Void){
        guard let url = URL(string: urlString) else {
            completion(nil)
            return
            
        }
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else {
                completion(nil)
                return

            }
            DispatchQueue.main.async {
                completion(UIImage(data: data))
            }
        }
        task.resume()
    }
    
}
