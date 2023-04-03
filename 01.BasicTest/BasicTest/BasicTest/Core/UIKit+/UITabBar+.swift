//
//  UITabBar+.swift
//
//  Created by Junho Lee on 2022/09/24.
//  Copyright © 2022 BasicTest. All rights reserved.
//

import UIKit

public extension UITabBar {
    
    static func clearShadow() {
        UITabBar.appearance().shadowImage = UIImage()
        UITabBar.appearance().backgroundImage = UIImage()
        UITabBar.appearance().backgroundColor = UIColor.white
    }
}
