//
//  SideMenuSection.swift
//  GoogleMapTutorial
//
//  Created by Kang Mingu on 2021/02/08.
//

import Foundation

struct SideMenuSection {
    var title: String!
    var menus: [String]!
    var viewControllers: [AnyObject]!
    var isCheckLogin: [Bool]!
    var isExpand: Bool!
    
    init(title: String, menus: [String], viewControllers: [AnyObject], isCheckLogin: [Bool], isExpand: Bool) {
        self.title = title
        self.menus = menus
        self.viewControllers = viewControllers
        self.isCheckLogin = isCheckLogin
        self.isExpand = isExpand
    }
    
}
