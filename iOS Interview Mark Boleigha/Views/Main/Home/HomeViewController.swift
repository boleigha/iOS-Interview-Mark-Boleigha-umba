//
//  HomeViewController.swift
//  iOS Interview Mark Boleigha
//
//  Created by Mark Boleigha on 17/01/2022.
//

import UIKit
//import Scra
import Signals

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
    var viewModel: HomeViewModel!
    
    init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
        
        popularView.items.dataSource = viewModel
        upcomingView.items.dataSource = viewModel
        
        upcomingView.see_all.onTouchUpInside.subscribe(with: self) {
            Navigation.select(item: 3)
        }
        
        popularView.see_all.onTouchUpInside.subscribe(with: self) {
            Navigation.select(item: 2)
        }
        
        latestView.clicked.subscribe(with: self) { (movie) in
            let view = MovieDetailViewController(movie: movie)
            self.navigationController?.pushViewController(view, animated: true)
        }
        
        upcomingView.clicked.subscribe(with: self) { (movie) in
            let view = MovieDetailViewController(movie: movie)
            self.navigationController?.pushViewController(view, animated: true)
        }
        
        popularView.clicked.subscribe(with: self) { (movie) in
            let view = MovieDetailViewController(movie: movie)
            self.navigationController?.pushViewController(view, animated: true)
        }
        loadMovies()
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
        popularView.items.contentInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
    }
    
    func loadMovies() {
        viewModel.loadVideos(category: .latest) { [weak self] in
            guard let self_ = self, let latest = self_.viewModel.latest else {
                return
            }
            self_.latestView.render(with: latest)
        }
        
        viewModel.loadVideos(category: .popular) { [weak self] in
            guard let self_ = self else {
                return
            }
            self_.popularView.items.reloadData()
        }
        
        viewModel.loadVideos(category: .upcoming) { [weak self] in
            guard let self_ = self else {
                return
            }
            self_.upcomingView.items.reloadData()
        }
    }

}
