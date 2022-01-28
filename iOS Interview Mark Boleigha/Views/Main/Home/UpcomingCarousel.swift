//
//  UpcomingCarousel.swift
//  iOS Interview Mark Boleigha
//
//  Created by Mark Boleigha on 18/01/2022.
//  Copyright © 2022 Umba. All rights reserved.
//

import Foundation
import WidgetUI
import Signals

class UpcomingCarousel: UIView {

    lazy var title_label: Text = {
        let txt = Text()
        txt.font = Font.body.make(font: "Lato-Regular", withSize: 16)
        txt.content = "Upcoming".attributed
        txt.textColor = Colors.darkerBlue
        return txt
    }()
    
    lazy var see_all: UIButton = {
        let btn = UIButton()
        btn.setTitle("See All >>>", for: .normal)
        btn.titleLabel?.font = Font.body.make(font: "Lato-Regular", withSize: 11)
        btn.setTitleColor(.black, for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    lazy var items: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 16
        let items = UICollectionView(frame: .zero, collectionViewLayout: layout)
        items.register(UpcomingMoviesCell.self, forCellWithReuseIdentifier: UpcomingMoviesCell.identifier)
        items.translatesAutoresizingMaskIntoConstraints = false
        items.isUserInteractionEnabled = true
        items.tag = 1
        return items
    }()
    
    lazy var retry_btn: UIButton = {
        let btn = UIButton(frame: .zero)
        btn.setTitle("Retry", for: .normal)
        btn.setTitleColor(.black, for: .normal)
        btn.titleLabel?.font = Font.body.make(font: "Lato-Regular", withSize: 15)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    let clicked = Signal<MovieResponse>()
    let retry = Signal<()>()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initView() {
        self.addSubviews([title_label, items, see_all, retry_btn])
        items.delegate = self
        items.backgroundColor = UIColor(hex: "#ffffff")
        title_label.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: nil, padding: UIEdgeInsets(top: 16, left: 16, bottom: 0, right: 0))
        items.anchor(top: title_label.bottomAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: UIEdgeInsets(top: 8, left: 0, bottom: 0, right: 0))
        
        see_all.anchor(top: topAnchor, leading: nil, bottom: title_label.bottomAnchor, trailing: trailingAnchor, padding: UIEdgeInsets(top: 16, left: 0, bottom: 0, right: 16))
//        see_all.heightAnchor.constraint(equalToConstant: 18).isActive = true
        see_all.widthAnchor.constraint(equalToConstant: 60).isActive = true
        
        retry_btn.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        retry_btn.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        retry_btn.widthAnchor.constraint(equalToConstant: 100).isActive = true
        retry_btn.heightAnchor.constraint(equalToConstant: 40).isActive = true
        retry_btn.isHidden = true
        retry_btn.onTouchUpInside.subscribe(with: self) { () in
            self.retry => ()
        }
        
    }
    
    func showRetry() {
        retry_btn.isHidden = false
    }
    
    func hideRetry() {
        retry_btn.isHidden = true
        self.items.reloadData()
    }
}

extension UpcomingCarousel: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
   
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? UpcomingMoviesCell else {
            return
        }
        self.clicked => cell.movie
//        let movie = v
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        let height = items.bounds.height - 12
        let width = CGFloat(UIScreen.main.bounds.width - 26) / 2
       return CGSize(width: width, height: 200)
    }
}

class UpcomingMoviesCell: UICollectionViewCell {
    
    static let identifier = "upcoming"
    
    lazy var cover: UIImageView = {
        let icon = UIImageView()
        icon.translatesAutoresizingMaskIntoConstraints = false
        return icon
    }()
        
    lazy var title: UILabel = {
        let font = Font.heading.make(font: "Lato-Regular", withSize: 12)
        let txt = Text(font: font, content: nil)
        txt.textColor = .white
        txt.numberOfLines = 0
        txt.lineBreakMode = .byWordWrapping
        txt.translatesAutoresizingMaskIntoConstraints = false
        return txt
    }()
    //
    lazy var rating: UILabel = {
        let font = Font.body.make(font: "Lato-Regular", withSize: 14)
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
        
    var movie: MovieResponse!
    
    override init(frame: CGRect) {
         super.init(frame: frame)
         initView()
    }
         
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
        
    func initView() {
        let backdrop = UIView()
        backdrop.backgroundColor = UIColor(hex: "333333").withAlphaComponent(0.7)
        backdrop.addSubviews([title, star, rating])
        
        self.backgroundColor = UIColor(hex: "333333")
        self.addSubviews([cover, backdrop])
        self.layer.cornerRadius = 2
        
        backdrop.anchor(top: nil, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor)
        backdrop.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        cover.anchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor)
        
        title.anchor(top: backdrop.topAnchor, leading: backdrop.leadingAnchor, bottom: backdrop.bottomAnchor, trailing: star.leadingAnchor, padding: UIEdgeInsets(top: 4, left: 10, bottom: 10, right: 5))
        star.anchor(top: nil, leading: nil, bottom: backdrop.bottomAnchor, trailing: rating.leadingAnchor, padding: UIEdgeInsets(top: 0, left: 0, bottom: 10, right: 5))
        
        rating.anchor(top: nil, leading: star.trailingAnchor, bottom: backdrop.bottomAnchor, trailing: backdrop.trailingAnchor, padding: UIEdgeInsets(top: 0, left: 0, bottom: 10, right: 10))
        rating.widthAnchor.constraint(equalToConstant: 30).isActive = true
        rating.heightAnchor.constraint(equalToConstant: 22).isActive = true
        
        star.heightAnchor.constraint(equalToConstant: 20).isActive = true
        star.widthAnchor.constraint(equalToConstant: 20).isActive = true
        
        self.addShadow()
    }
        
    func render() {
        self.title.text = self.movie.original_title
        self.rating.text = String( self.movie.vote_average )
        
        self.title.sizeToFit()
        self.rating.sizeToFit()
        guard let poster = movie.poster_path else {
            return
        }
        if poster != "" {
            let url = API.movies(.get_image(path: poster))
            ImageLoader.loadImageData(urlString: url.stringValue) { (image) in
                self.cover.image = image
            }
        }
        
        
    }
}

