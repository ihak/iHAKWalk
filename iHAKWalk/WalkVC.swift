//
//  WalkVC.swift
//  ihakwalk
//
//  Created by Hassan Ahmed on 14/03/2019.
//  Copyright © 2019 Hassan Ahmed. All rights reserved.
//

import UIKit

class WalkVC: UIViewController {
    var walkSlider: WalkSlider!
    
    convenience init(walkSlider: WalkSlider) {
        self.init()
        self.walkSlider = walkSlider
        self.walkSlider.skipButtonAction { (_) in
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        addWalkSlider()
    }
    
    func addWalkSlider() {
        walkSlider.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(walkSlider)
        
        walkSlider.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        walkSlider.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        walkSlider.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        walkSlider.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
    }
}
