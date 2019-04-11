//
//  ProductSliderVC.swift
//  ihakwalk
//
//  Created by Hassan Ahmed on 29/03/2019.
//  Copyright © 2019 Hassan Ahmed. All rights reserved.
//

import UIKit
import iHAKWalk

class ProductSliderVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let headerImageView = UIImageView(image: UIImage(named: "header_placeholder")!)
        headerImageView.translatesAutoresizingMaskIntoConstraints = false
        headerImageView.contentMode = .scaleAspectFill
        
        self.view.addSubview(headerImageView)
        headerImageView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        headerImageView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        headerImageView.heightAnchor.constraint(equalToConstant: 64.0).isActive = true
        headerImageView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        
        let bannerView = UIView()
        bannerView.backgroundColor = UIColor(red: 214.0/256.0, green: 214.0/256.0, blue: 214.0/256.0, alpha: 1.0)
        bannerView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(bannerView)
        
        bannerView.topAnchor.constraint(equalTo: headerImageView.bottomAnchor).isActive = true
        bannerView.widthAnchor.constraint(equalTo: bannerView.heightAnchor, multiplier: 2.0).isActive = true
        bannerView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        bannerView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        
        
        let productsImage = UIImageView(image: UIImage(named: "products_placeholder"))
        productsImage.translatesAutoresizingMaskIntoConstraints = false
        productsImage.contentMode = .scaleToFill

        self.view.addSubview(productsImage)
        productsImage.topAnchor.constraint(equalTo: bannerView.bottomAnchor).isActive = true
        productsImage.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        productsImage.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        productsImage.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        
        let dismissButton = UIButton(type: .custom)
        dismissButton.setTitle("", for: .normal)
        dismissButton.addTarget(self, action: #selector(dismissButtonTapped(_:)), for: .touchUpInside)
        
        dismissButton.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(dismissButton)
        
        dismissButton.topAnchor.constraint(equalTo: productsImage.topAnchor).isActive = true
        dismissButton.bottomAnchor.constraint(equalTo: productsImage.bottomAnchor).isActive = true
        dismissButton.leadingAnchor.constraint(equalTo: productsImage.leadingAnchor).isActive = true
        dismissButton.trailingAnchor.constraint(equalTo: productsImage.trailingAnchor).isActive = true
        
        createBannerSlider(in: bannerView)
    }
    
    func createBannerSlider(in containerView: UIView) {
        let bg1 = WalkBGView(image: UIImage(named: "banner_1"))
        
        bg1.configureTap { (view) in
            let alertVC = UIAlertController(title: "Banner 1", message: "Banner 1 tapped.", preferredStyle: .alert)
            alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            self.present(alertVC, animated: true, completion: nil)
        }
        
        let bg2 = WalkBGView(image: UIImage(named: "banner_2"))
        let bg3 = WalkBGView(image: UIImage(named: "banner_3"))
        let bg4 = WalkBGView(image: UIImage(named: "banner_4"))
        let bg5 = WalkBGView(image: UIImage(named: "banner_5"))
        
        let walkSlider = WalkSlider(milestones: [bg1, bg2, bg3, bg4, bg5])
        let walkVC = WalkVC(walkSlider: walkSlider)
        walkSlider.addPageControl()
        self.addChild(walkVC)
        walkVC.view.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(walkVC.view)
        
        walkVC.view.topAnchor.constraint(equalTo: containerView.topAnchor).isActive = true
        walkVC.view.bottomAnchor.constraint(equalTo: containerView.bottomAnchor).isActive = true
        walkVC.view.leadingAnchor.constraint(equalTo: containerView.leadingAnchor).isActive = true
        walkVC.view.trailingAnchor.constraint(equalTo: containerView.trailingAnchor).isActive = true
    }
    
    @objc func dismissButtonTapped(_ sender: UIButton) {
        self.navigationController?.dismiss(animated: true, completion: nil)
    }
}
