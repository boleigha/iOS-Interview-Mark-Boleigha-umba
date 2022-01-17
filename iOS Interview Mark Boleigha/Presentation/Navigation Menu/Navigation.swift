//
//  Navigation.swift
//  iOS Interview Mark Boleigha
//
//  Created by Mark Boleigha on 17/01/2022.
//
import UIKit

class Navigation: UITabBarController {
    
    private var menu: TabMenu!
    private let menuItems: [MenuItem] = [.home, .latest, .popular, .upcoming]
    
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
        self.view.backgroundColor = .white
        self.navigationController?.navigationBar.backgroundColor = .none
        self.createMenu()
    }
    
    private func createMenu() {
        let width = tabBar.frame.width - 20
        let frame = CGRect(x: 0, y: 0, width: width, height: 0)
        
        // create custom tab menu
        self.menu = TabMenu(frame: frame, tabMenuItems: self.menuItems)
        self.menu.willSetConstraints()
        self.menu.layer.cornerRadius = 8
        
        // Add it to the view
        self.view.addSubview(self.menu)
        self.menu.anchor(top: nil, leading: tabBar.leadingAnchor, bottom: self.view.bottomAnchor, trailing: tabBar.trailingAnchor, padding:UIEdgeInsets(top: 0, left: 10, bottom: 5, right: 10) )
        self.menu.heightAnchor.constraint(equalToConstant: 56).isActive = true
        self.viewControllers = menuItems.map({ $0.viewController })
        
        self.menu.addShadow(color: UIColor.black, withOffset: CGSize(width: 0, height: -5))
        self.menu.clipsToBounds = false
        self.menu.activateTab(viewId: self.menu.activeTabIndex)
        
        self.menu.itemTapped.subscribe(with: self) { (item) in
            self.selectedIndex = item
        }
    }
    
    static func setUpAsRootViewController(completion: (() -> Void)? = nil) {
        AppDelegate.shared.setRootViewController(controller: self.shared)
        if completion != nil {
            completion!()
        }
    }
}

