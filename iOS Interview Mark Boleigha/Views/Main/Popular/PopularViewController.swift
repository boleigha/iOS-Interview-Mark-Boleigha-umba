//
//  PopularViewController.swift
//  iOS Interview Mark Boleigha
//
//  Created by Mark Boleigha on 19/01/2022.
//  Copyright © 2022 Umba. All rights reserved.
//

import UIKit
import WidgetUI

class PopularViewController: UIViewController {

    var viewModel: HomeViewModel!
     lazy var title_label: UILabel = {
         let font = Font.heading.make(font: "Lato-Regular", withSize: 16)
         let txt = Text(font: font, content: "Popular Items View".attributed)
         txt.translatesAutoresizingMaskIntoConstraints = false
         return txt
     }()
     
     init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
     
     required init?(coder: NSCoder) {
         fatalError("init(coder:) has not been implemented")
     }
     
     override func viewDidLoad() {
         super.viewDidLoad()
         self.view.addSubview(title_label)
         view.backgroundColor = .white
         
         title_label.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
         title_label.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
     }

}
