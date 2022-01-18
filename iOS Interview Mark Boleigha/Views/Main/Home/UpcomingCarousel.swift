//
//  UpcomingCarousel.swift
//  iOS Interview Mark Boleigha
//
//  Created by Mark Boleigha on 18/01/2022.
//  Copyright © 2022 Umba. All rights reserved.
//

import Foundation
import WidgetUI

class UpcomingCarousel: UIView {
    
//    lazy var title_label: UILabel = {
//       let font = Font.body.make(withSize: 16
//    }()

    lazy var title_label: Text = {
        let txt = Text()
        txt.font = Font.body.make(font: "Lato-Regular", withSize: 16)
        txt.content = "Upcoming".attributed
        txt.textColor = Colors.darkerBlue
        return txt
    }()
    
    lazy var see_all: Text = {
        let txt = Text()
        txt.font = Font.body.make(font: "Lato-Regular", withSize: 11)
        txt.content = "See All >>>".attributed
        txt.textColor = Colors.darkerBlue
        return txt
    }()
    
    lazy var items: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 16
        let items = UICollectionView(frame: .zero, collectionViewLayout: layout)
        items.register(UpcomingMoviesCell.self, forCellWithReuseIdentifier: UpcomingMoviesCell.identifier)
        items.translatesAutoresizingMaskIntoConstraints = false
        items.isUserInteractionEnabled = true
        return items
    }()
    
    let category: HomeCategories = .upcoming
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initView() {
        self.addSubviews([title_label, items, see_all])
        items.delegate = self
        items.dataSource = self
        items.backgroundColor = UIColor(hex: "#ffffff")
        title_label.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: nil, padding: UIEdgeInsets(top: 16, left: 16, bottom: 0, right: 0))
        items.anchor(top: title_label.bottomAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: UIEdgeInsets(top: 8, left: 0, bottom: 0, right: 0))
        
        see_all.anchor(top: topAnchor, leading: nil, bottom: title_label.bottomAnchor, trailing: trailingAnchor, padding: UIEdgeInsets(top: 16, left: 0, bottom: 0, right: 16))
        
        see_all.addGestureRecognizer(UITapGestureRecognizer(target: self, action: nil))
    }
}

extension UpcomingCarousel: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: UpcomingMoviesCell.identifier, for: indexPath) as? UpcomingMoviesCell else {
            return UICollectionViewCell()
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        let height = items.bounds.height - 12
        let width = CGFloat(items.bounds.width - 26) / 2
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
        let font = Font.heading.make(font: "Lato-Light", withSize: 16)
        let txt = Text(font: font, content: nil)
        txt.textColor = .white
        txt.numberOfLines = 0
        txt.translatesAutoresizingMaskIntoConstraints = false
        return txt
    }()
//
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
    
    var movie: MovieResponse!
    
    override init(frame: CGRect) {
         super.init(frame: frame)
         initView()
    }
     
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func initView() {
        self.backgroundColor = UIColor(hex: "333333")
        self.addSubviews([cover, title, star, rating])
        self.layer.cornerRadius = 2
        
        cover.anchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor)
        title.anchor(top: nil, leading: leadingAnchor, bottom: bottomAnchor, trailing: nil, padding: UIEdgeInsets(top: 0, left: 10, bottom: 10, right: 5))
        star.anchor(top: nil, leading: nil, bottom: bottomAnchor, trailing: nil, padding: UIEdgeInsets(top: 0, left: 0, bottom: 10, right: 5))
        rating.anchor(top: nil, leading: star.trailingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: UIEdgeInsets(top: 0, left: 0, bottom: 10, right: 10))
        
        star.heightAnchor.constraint(equalToConstant: 20).isActive = true
        star.widthAnchor.constraint(equalToConstant: 20).isActive = true
        
        self.addShadow()
        
        title.text = "Title"
        rating.text = "5.0"
    }
}

