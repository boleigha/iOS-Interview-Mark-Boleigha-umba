//
//  Navigation.swift
//  iOS Interview Mark Boleigha
//
//  Created by Mark Boleigha on 17/01/2022.
//  Copyright © 2022 Umba. All rights reserved.
//
import UIKit

class Navigation: UITabBarController {
    
    private var circleView : UIView!
    private var circleImageView: UIImageView!
    private var circleViewCenter: NSLayoutConstraint!

    class var shared: Navigation {
        struct Static {
            static let instance: Navigation = Navigation()
        }
        return Static.instance
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBar.isHidden = true
        self.navigationController?.navigationBar.isHidden = true
        self.view.backgroundColor = .green
        self.navigationController?.navigationBar.backgroundColor = .none
//        self.createTabNavigationMenu()
    }
    
    
    static func setUpAsRootViewController(completion: (() -> Void)? = nil) {
        AppDelegate.shared.setRootViewController(controller: self.shared)
        if completion != nil {
            completion!()
        }
    }
}

//extension Navigation: TabMenuDelegate {
//    func itemTapped(item: Int) {
//        self.selectedIndex = item
//
//        let anchor = CGFloat(self.customTabBar.itemWidth * CGFloat(item)) + 20
//        let tab = self.customTabBar.subviews[item] as! TabMenuItem
//
//        UIView.animate(withDuration: 0.5, animations: {
//            self.circleImageView.image = tab.icon
//            self.circleViewCenter.constant = anchor
//            self.circleView.setNeedsDisplay()
//        })
//    }
//}
