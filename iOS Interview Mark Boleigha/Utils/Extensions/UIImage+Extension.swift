//
//  UIImage+Extension.swift
//  iOS Interview Mark Boleigha
//
//  Created by Mark Boleigha on 18/01/2022.
//  Copyright © 2022 Umba. All rights reserved.
//

import Foundation
import UIKit

extension UIImage {
    func loadImageData(urlString: String, _ completion: @escaping (UIImage?) -> Void){
        let string = "https://image.tmdb.org/t/p/w500/" + urlString.replacingOccurrences(of: "/", with: "")
        guard let url = URL(string: string) else {
            completion(nil)
            return
            
        }
        let task = URLSession.shared.dataTask(with: url) {[weak self] data, response, error in
            guard let data = data else {
                completion(nil)
                return

            }
            DispatchQueue.main.async {
                print("The uiImage completed \(UIImage(data: data)?.pngData())")
                 completion(UIImage(data: data))
            }
        }
        task.resume()
    }
}
