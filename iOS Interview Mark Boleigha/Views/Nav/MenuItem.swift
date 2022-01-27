//
//  MenuItem.swift
//  iOS Interview Mark Boleigha
//
//  Created by Mark Boleigha on 20/01/2022.
//  Copyright © 2022 Umba. All rights reserved.
//
import UIKit
import WidgetUI

enum MenuItem: String, CaseIterable {
    case home
    case latest
    case popular
    case upcoming
    
    var viewController: UIViewController {
        let viewModel = HomeViewModel()
        switch self {
        case .home:
            return HomeViewController(viewModel: viewModel).wrapInNavigation()
        case .latest:
            return LatestViewController(viewModel: viewModel).wrapInNavigation()
        case .upcoming:
            return UpcomingViewController(viewModel: viewModel).wrapInNavigation()
        case .popular:
            return PopularViewController(viewModel: viewModel).wrapInNavigation()
        }
    }
    
    var icon: UIImage {
        return UIImage(named: "\(self.rawValue)")!.withRenderingMode(.alwaysTemplate)
    }
    
    var title: String {
        return self.rawValue.capitalized
    }
}
