//
//  UIStackView+.swift
//
//  Created by Junho Lee on 2022/09/24.
//  Copyright © 2022 BasicTest. All rights reserved.
//

import UIKit

public extension UIStackView {
     func addArrangedSubviews(_ views: UIView...) {
         for view in views {
             self.addArrangedSubview(view)
         }
     }
}
