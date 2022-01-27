//
//  TabMenu.swift
//  iOS Interview Mark Boleigha
//
//  Created by Mark Boleigha on 20/01/2022.
//  Copyright © 2022 Umba. All rights reserved.
//
import UIKit
import Signals
import WidgetUI

class TabMenu: UIView {

    var previousIndex: Int! = 0
    var activeTabIndex: Int = 0 {
        willSet {
            self.previousIndex = self.activeTabIndex
        }
    }
    
    var itemWidth: CGFloat!
    
    var borderLayer: CAShapeLayer! = CAShapeLayer()
    
    let itemTapped = Signal<Int>()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
        
    convenience init(frame: CGRect, tabMenuItems: [MenuItem]) {
        self.init(frame: frame)
        self.backgroundColor = UIColor.black
        self.addShadow(color: UIColor.black.withAlphaComponent(0.25), withOffset: CGSize(width: 0, height: -3))
        self.tintColor = Colors.crimson
        
        self.itemWidth = self.bounds.width / CGFloat(tabMenuItems.count)
        
        for i in 0 ..< tabMenuItems.count {
            let leadingAnchor = itemWidth * CGFloat(i)
            
            let itemView = TabMenuItem(menuItem: tabMenuItems[i], asActive: (i == self.activeTabIndex) ? true : false, iconSize: nil)
            itemView.tag = i
            
            self.addSubview(itemView)
            itemView.willSetConstraints()
            
            NSLayoutConstraint.activate([
                itemView.heightAnchor.constraint(equalTo: self.heightAnchor),
                itemView.widthAnchor.constraint(equalToConstant: itemWidth),
                itemView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: leadingAnchor),
                itemView.topAnchor.constraint(equalTo: self.topAnchor),
            ])
            itemView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.handleItemTapped)))
        }
        self.borderLayer.fillColor = UIColor.clear.cgColor
        self.borderLayer.strokeColor = UIColor.black.withAlphaComponent(0.4).cgColor
        self.borderLayer.frame = self.bounds
        self.borderLayer.shadowOpacity = 0.7
        self.borderLayer.shadowRadius = 5
        self.layer.addSublayer(self.borderLayer)
    }
    
    @objc func handleItemTapped(_ gesture: UIGestureRecognizer) {
        self.activeTabIndex = self.subviews.firstIndex(of: gesture.view!)!
        self.switchTab(to: self.activeTabIndex)
    }
    
    public func switchTab(to newTabId: Int) {
        self.deactivateTab(viewId: self.previousIndex)
        self.activateTab(viewId: newTabId)
    }
    
    func deactivateTab(viewId: Int) {
        let tab = self.subviews[viewId] as! TabMenuItem
        tab.isSelected = false
        tab.iconView.image = tab.icon
    }
    
    func activateTab(viewId: Int) {
        let tab = self.subviews[viewId] as! TabMenuItem
        tab.isSelected = true
        DispatchQueue.main.async {
            self.activeTabIndex = viewId
            self.itemTapped => viewId
        }
    }
}

class TabMenuItem: UIView {
    var icon: UIImage?
    var controller: UIViewController?
    
    lazy var displayTitle: Text = {
        let font = UIFont(name: "Lato-Regular", size: 11)
        return Text(font: font, content: nil, color: .white)
    }()
    var iconView: UIImageView = UIImageView(frame: .zero)
    
    var isSelected: Bool = false {
        didSet {
            if self.isSelected {
                self.iconView.tintColor = Colors.crimson
                self.iconView.image = self.icon
                self.displayTitle.textColor = Colors.crimson
            } else {
                self.iconView.image = self.icon
                self.iconView.tintColor = .white
                self.displayTitle.textColor = .white

            }
            self.setNeedsLayout()
            self.layoutIfNeeded()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.iconView.willSetConstraints()
        self.displayTitle.willSetConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(menuItem: MenuItem, asActive: Bool, iconSize: CGSize? = nil) {
        self.init(frame: .zero)
        
        self.controller = menuItem.viewController
        self.icon = menuItem.icon
        self.isSelected = asActive
        
        self.iconView.image = self.icon?.withRenderingMode(.alwaysTemplate)
        self.iconView.tintColor = self.isSelected ? Colors.crimson : UIColor(hex: "FFFFFF")
        self.displayTitle.text = menuItem.title
        self.displayTitle.sizeToFit()
        
        addSubview(self.iconView)
        addSubview(self.displayTitle)
        
        NSLayoutConstraint.activate([
            self.iconView.heightAnchor.constraint(equalToConstant: iconSize?.height ?? 24),
            self.iconView.widthAnchor.constraint(equalToConstant: iconSize?.width ?? 24),
            self.iconView.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            self.iconView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
        ])
        
        self.displayTitle.anchor(top: iconView.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: UIEdgeInsets(top: 3.26, left: 1, bottom: 0, right: 1))
        displayTitle.textAlignment = .center
    }
}
