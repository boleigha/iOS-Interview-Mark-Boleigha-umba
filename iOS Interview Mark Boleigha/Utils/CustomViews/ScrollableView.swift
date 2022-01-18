//
//  ScrollableView.swift
//  iOS Interview Mark Boleigha
//
//  Created by Mark Boleigha on 17/01/2022.
//  Copyright © 2022 Mark Boleigha. All rights reserved.
//

import UIKit

open class ScrollableView: UIViewController {
    
    public lazy var content: UIStackView = {
        let contentView = UIStackView(frame: .zero)
        contentView.axis = .vertical
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.clipsToBounds = true
        contentView.distribution = .fill
        return contentView
    }()
    
    public lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView(frame: .zero)
        scrollView.isDirectionalLockEnabled = true
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.clipsToBounds = true
        return scrollView
    }()
    
    public func setup() {
        self.embedInScrollView(self.content)
    }
    
    public func embedInScrollView(_ content: UIView) {
        self.scrollView.addSubview(self.content)
        
        self.view.addSubview(scrollView)
        self.view.backgroundColor = .none

        DispatchQueue.main.async {
           NSLayoutConstraint.activate([
            self.scrollView.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            self.scrollView.rightAnchor.constraint(equalTo: self.view.rightAnchor),
            self.scrollView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            self.scrollView.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.scrollView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.scrollView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
                   
            self.content.topAnchor.constraint(equalTo: self.scrollView.topAnchor),
            self.content.leadingAnchor.constraint(equalTo: self.scrollView.leadingAnchor),
            self.content.trailingAnchor.constraint(equalTo: self.scrollView.trailingAnchor),
            self.content.bottomAnchor.constraint(equalTo: self.scrollView.bottomAnchor),
            self.content.centerXAnchor.constraint(equalTo: self.scrollView.centerXAnchor),
           ])
            self.content.backgroundColor = .white
            
            self.scrollView.backgroundColor = .none
            self.scrollView.setNeedsDisplay()
            self.scrollView.layoutIfNeeded()
       }
    }
    
    public func addView(view: Any, at index: Int? = nil) {
        DispatchQueue.main.async {
            (index != nil) ? self.content.insertArrangedSubview(view as! UIView, at: index!) : self.content.addArrangedSubview(view as! UIView)
        }
    }
    
    public func addViews(_ views: [Any]) {
        for view in views {
            self.content.addArrangedSubview(view as! UIView)
        }
    }
}
