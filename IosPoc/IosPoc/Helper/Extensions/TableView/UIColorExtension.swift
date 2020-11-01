//
//  UIColorExtension.swift
//  IosPoc
//
//  Created by Ankush Dhawan on 11/1/20.
//  Copyright © 2020 Ankush Dhawan. All rights reserved.
//

import Foundation
import UIKit
extension UIColor{
    
    static var dynamicBackgroundColor: UIColor{
        
        if #available(iOS 13.0, *) {
            return  UIColor { (collection) -> UIColor in
                if collection.userInterfaceStyle == .dark{
                    return UIColor.black.withAlphaComponent(1)
                }else{
                    return UIColor.white.withAlphaComponent(1)
                }
            }
        } else {
            // Fallback on earlier versions
return UIColor.white.withAlphaComponent(1)        }
    }
    
    static var dynamicNavigationBarColor: UIColor{
            
            if #available(iOS 13.0, *) {
                return  UIColor { (collection) -> UIColor in
                    if collection.userInterfaceStyle == .dark{
                        return UIColor.black.withAlphaComponent(1)
                    }else{
                        return UIColor.gray.withAlphaComponent(1)
                    }
                }
            } else {
                // Fallback on earlier versions
    return UIColor.gray.withAlphaComponent(1)        }
        }
    static var dynamicTextColor: UIColor{
           
        if #available(iOS 13.0, *) {
            return  UIColor { (collection) -> UIColor in
                if collection.userInterfaceStyle == .dark{
                    return UIColor.white
                }else{
                    return UIColor.black.withAlphaComponent(1)
                }
            }
        } else {
            // Fallback on earlier versions
            return UIColor.white.withAlphaComponent(1)
        }
       }
}

