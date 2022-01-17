//
//  TabMenuItem.swift
//  iOS Interview Mark Boleigha
//
//  Created by Mark Boleigha on 17/01/2022.
//

import UIKit
import WidgetUI

enum MenuItem: String, CaseIterable {
    case home
    case latest
    case popular
    case upcoming
    
    var viewController: UIViewController {
        switch self {
        case .home:
            return HomeViewController().wrapInNavigation()
        default:
            return UIViewController()
        }
    }
    
    var icon: UIImage {
        return UIImage(named: "\(self.rawValue)")!.withRenderingMode(.alwaysTemplate)
    }
    
    var title: String {
        return self.rawValue.capitalized
    }
}
