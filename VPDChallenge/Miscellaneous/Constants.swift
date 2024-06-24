//
//  Constants.swift
//  LawPavillionApp
//
//  Created by Apple on 5/15/22.
//

import Foundation
import UIKit

class Constants {
    
// MARK: - String Constants
    
    static let url = "https://api.github.com/search/repositories?q="
    
// MARK: - UI Constants
    
    static let navyBlue = UIColor(hex: "#2F466C")
    let yvTextbg = UIColor(red: 241/255, green: 241/255, blue: 247/255, alpha: 0.8)
    let valuebg = UIColor(red: 130/255, green: 130/255, blue: 130/255, alpha: 1.0)
    
    static func boldFont(size: Int) -> UIFont {
        
        return UIFont(name: "Poppins-Bold", size: CGFloat(size))!
    }
    
    static func regularFont(size: Int) -> UIFont {
        
        return UIFont(name: "Poppins-Regular", size: CGFloat(size))!
    }
    
    static func semiBoldFont(size: Int) -> UIFont {
        
        return UIFont(name: "Poppins-SemiBold", size: CGFloat(size))!
    }
    
    static func lightFont(size: Int) -> UIFont {
        
        return UIFont(name: "Poppins-Light", size: CGFloat(size))!
    }
    
    
    
// MARK: - String Constants
}

let yvTextbg = UIColor(red: 241/255, green: 241/255, blue: 247/255, alpha: 0.8)
let valuebg = UIColor(red: 130/255, green: 130/255, blue: 130/255, alpha: 1.0)
