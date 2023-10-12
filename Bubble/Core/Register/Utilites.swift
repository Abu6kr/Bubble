//
//  Utilites.swift
//  Bubble
//
//  Created by Abobakr Al Zain  on 12.10.2023.
//

import Foundation
import UIKit

final class Utilites {
    
    static let sherd = Utilites()
    private init() { }
    
    @MainActor
     func topViewController(controller: UIViewController? = nil) -> UIViewController? {
         let controller = controller ?? UIApplication.shared.keyWindow?.rootViewController
         
        if let navigationController = controller as? UINavigationController {
            return topViewController(controller: navigationController.visibleViewController)
        }
        if let tabController = controller as? UITabBarController {
            if let selected = tabController.selectedViewController {
                return topViewController(controller: selected)
            }
        }
        if let presented = controller?.presentedViewController {
            return topViewController(controller: presented)
        }
        return controller
    }
}
