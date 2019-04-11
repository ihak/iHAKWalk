//
//  UIColor+Image.swift
//  MeWord
//
//  Created by Hassan Ahmed on 13/03/2019.
//  Copyright © 2019 Hassan Ahmed. All rights reserved.
//

import UIKit

extension UIColor {
    func image(_ size: CGSize = CGSize(width: 1, height: 1)) -> UIImage {
        return UIGraphicsImageRenderer(size: size).image { rendererContext in
            self.setFill()
            rendererContext.fill(CGRect(origin: .zero, size: size))
        }
    }
}
