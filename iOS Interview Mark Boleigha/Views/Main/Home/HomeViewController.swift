//
//  HomeViewController.swift
//  iOS Interview Mark Boleigha
//
//  Created by Mark Boleigha on 17/01/2022.
//

import UIKit
//import Scra

enum HomeCategories {
    case popular, upcoming, latest
}

class HomeViewController: ScrollableView {
    
    lazy var latestView: LatestMovieCarousel = {
        let view = LatestMovieCarousel()
        return view
    }()

    lazy var popularView: PopularContentView = {
        let view = PopularContentView()
        return view
    }()
    
    lazy var upcomingView: UpcomingCarousel = {
        let view = UpcomingCarousel()
        return view
    }()
    
    var scrollViewConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.setup()
        view.backgroundColor = UIColor(hex: "FFFFFF")
        content.spacing = 8
    
        self.addViews([latestView, popularView, upcomingView])
        popularView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        latestView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        upcomingView.heightAnchor.constraint(greaterThanOrEqualToConstant: 500).isActive = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        upcomingView.items.contentInset = UIEdgeInsets(top: 0, left: 5, bottom: 70, right: 5)
        latestView.items.contentInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
    }

}
