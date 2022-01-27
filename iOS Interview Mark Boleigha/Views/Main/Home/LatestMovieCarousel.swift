//
//  LatestMovieCarousel.swift
//  iOS Interview Mark Boleigha
//
//  Created by Mark Boleigha on 18/01/2022.
//  Copyright © 2022 Umba. All rights reserved.
//

import UIKit
import WidgetUI
import Signals

class LatestMovieCarousel: UIView {
    
    lazy var title_label: Text = {
        let txt = Text()
        txt.font = Font.body.make(font: "Lato-Regular", withSize: 16)
        txt.content = "Latest".attributed
        txt.textColor = Colors.darkerBlue
        return txt
    }()
        
    lazy var card: LatestMovieCard = {
        let card = LatestMovieCard()
        card.translatesAutoresizingMaskIntoConstraints = false
        return card
    }()
    
    let clicked = Signal<Latest>()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initView() {
        self.addSubviews([title_label, card])
        
        title_label.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: UIEdgeInsets(top: 16, left: 16, bottom: 0, right: 0))
        
        card.anchor(top: title_label.bottomAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: UIEdgeInsets(top: 8, left: 10, bottom: 8, right: 10))
        
        card.layer.cornerRadius = 4
        card.addShadow()
        card.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(selected)))
    }
    
    func render(with movie: Latest) {
        card.movie = movie
        card.title_label.content = movie.original_title.attributed
        card.overview.content = movie.overview.attributed
        card.rating.text = movie.vote_average.formattedAmount!
        
        if let backdrop = movie.backdrop_path {
            let url = API.movies(.get_image(path: backdrop))
            ImageLoader.loadImageData(urlString: url.stringValue) { (image) in
                self.card.image.image = image
            }
        }
        card.setNeedsLayout()
    }
    
    @objc func selected() {
        guard let movie = card.movie else {
            return
        }
//        let movie = Movie(
        self.clicked => movie
    }
}

class LatestMovieCard: UIView {
    
    var movie: Latest?
    
    lazy var image: UIImageView = {
        return UIImageView()
    }()
    
    lazy var title_label: Text = {
        let font = Font.body.make(font: "Lato-Regular", withSize: 16)
        let txt = Text(font: font, content: nil)
        txt.textColor = .white
        return txt
    }()
    
    lazy var overview: Text = {
        let font = Font.body.make(font: "Lato-Regular", withSize: 11)
        let txt = Text(font: font, content: nil)
        txt.numberOfLines = 0
        txt.textColor = .white
        return txt
    }()
    
    lazy var rating: UILabel = {
        let font = Font.body.make(font: "Lato-Light", withSize: 14)
        let txt = Text(font: font, content: nil)
        txt.textColor = .white
        txt.translatesAutoresizingMaskIntoConstraints = false
        return txt
    }()
    
    lazy var star: UIImageView = {
        let img = UIImageView(image: UIImage(named: "star"))
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initView() {
        let backdrop = UIView()
        backdrop.backgroundColor = UIColor(hex: "333333").withAlphaComponent(0.7)
        backdrop.addSubviews([title_label, overview])
        
        self.addSubviews([image, backdrop, star, rating])
        
        image.anchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor)
        
        backdrop.anchor(top: nil, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor)
        backdrop.heightAnchor.constraint(equalToConstant: 80).isActive = true
        
        overview.anchor(top: title_label.bottomAnchor, leading: leadingAnchor, bottom: backdrop.bottomAnchor, trailing: backdrop.trailingAnchor, padding: UIEdgeInsets(top: 5, left: 8, bottom: 5, right: 8))
        overview.heightAnchor.constraint(equalToConstant: 60).isActive = true
        title_label.anchor(top: backdrop.topAnchor, leading: backdrop.leadingAnchor, bottom: overview.topAnchor, trailing: backdrop.trailingAnchor, padding: UIEdgeInsets(top: 5, left: 8, bottom: 5, right: 8))
        
        star.anchor(top: topAnchor, leading: nil, bottom: nil, trailing: nil, padding: UIEdgeInsets(top: 8, left: 0, bottom: 0, right: 5))
        rating.anchor(top: topAnchor, leading: star.trailingAnchor, bottom: nil, trailing: trailingAnchor, padding: UIEdgeInsets(top: 8, left: 0, bottom: 0, right: 10))
        
        star.heightAnchor.constraint(equalToConstant: 20).isActive = true
        star.widthAnchor.constraint(equalToConstant: 20).isActive = true
        self.bringSubviewToFront(backdrop)
        self.backgroundColor = .green
    }
}
