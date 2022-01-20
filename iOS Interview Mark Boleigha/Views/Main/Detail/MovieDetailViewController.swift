//
//  MovieDetailViewController.swift
//  iOS Interview Mark Boleigha
//
//  Created by Mark Boleigha on 19/01/2022.
//  Copyright © 2022 Umba. All rights reserved.
//

import UIKit
import WidgetUI

class MovieDetailViewController: ScrollableView {
    
    lazy var poster_image: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFit
        return view
    }()
    
//    lazy var overview_label: Text = {
//        let font = Font.heading.make(font: "Lato-Bold", withSize: 14)
//        let txt = Text(font: font, content: "Overview".attributed)
//        txt.numberOfLines = 0
//        txt.lineBreakMode = .byWordWrapping
//        return txt
//    }()
    
    lazy var overview_text: Text = {
        let font = Font.heading.make(font: "Lato-Regular", withSize: 18)
        let txt = Text(font: font, content: nil)
        txt.numberOfLines = 0
        txt.lineBreakMode = .byWordWrapping
        return txt
    }()
    
    lazy var title_text: Text = {
        let font = Font.heading.make(font: "Lato-Bold", withSize: 18)
        let txt = Text(font: font, content: nil)
        txt.numberOfLines = 0
        txt.textAlignment = .center
        txt.lineBreakMode = .byWordWrapping
        return txt
    }()
    
    var movie: Movie!
    
    init(movie: Movie) {
        self.movie = movie
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.setup()
        initView()
    }
    
    private func initView() {
        self.title = self.movie.original_title
        self.view.backgroundColor = .white
        self.addViews([poster_image, title_text, overview_text])
//        self.addSubviews([])
        
        poster_image.anchor(top: content.safeAreaLayoutGuide.topAnchor, leading: nil, bottom: nil, trailing: nil, padding: UIEdgeInsets(top: 30, left: 0, bottom: 0, right: 0))
        poster_image.widthAnchor.constraint(equalToConstant: 250).isActive = true
        poster_image.heightAnchor.constraint(equalToConstant: 350).isActive = true
        poster_image.centerXAnchor.constraint(equalTo: content.centerXAnchor).isActive = true
        
        title_text.anchor(top: poster_image.bottomAnchor, leading: content.leadingAnchor, bottom: nil, trailing: content.trailingAnchor, padding: UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0))
        overview_text.anchor(top: title_text.bottomAnchor, leading: content.leadingAnchor, bottom: nil, trailing: content.trailingAnchor, padding: UIEdgeInsets(top: 10, left: 10, bottom: 0, right: 10))
        overview_text.heightAnchor.constraint(greaterThanOrEqualToConstant: 100).isActive = true
        overview_text.sizeToFit()
        
        title_text.text = movie.original_title
        overview_text.text = movie.overview
        
        if let poster = self.movie.poster_path, poster != "" {
            let url = API.movies(.get_image(path: poster))
            ImageLoader.loadImageData(urlString: url.stringValue) { (image) in
                self.poster_image.image = image
            }
        }
    }
}
