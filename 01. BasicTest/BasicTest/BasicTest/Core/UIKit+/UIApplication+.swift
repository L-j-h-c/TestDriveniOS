//
//  UIApplication+.swift
//  RD-Core
//
//  Created by Junho Lee on 2022/10/12.
//  Copyright © 2022 BasicTest. All rights reserved.
//

import UIKit

public extension UIApplication {
    class func getMostTopViewController(base: UIViewController? = nil) -> UIViewController? {
        
        var baseVC: UIViewController?
        if base != nil {
            baseVC = base
        }
        else {
            baseVC = (UIApplication.shared.connectedScenes
                .compactMap { $0 as? UIWindowScene }
                .flatMap { $0.windows }
                .first { $0.isKeyWindow })?.rootViewController
        }
        
        if let naviController = baseVC as? UINavigationController {
            return getMostTopViewController(base: naviController.visibleViewController)
            
        } else if let tabbarController = baseVC as? UITabBarController, let selected = tabbarController.selectedViewController {
            return getMostTopViewController(base: selected)
            
        } else if let presented = baseVC?.presentedViewController {
            return getMostTopViewController(base: presented)
        }
        return baseVC
    }
}

