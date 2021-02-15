//
//  SideMenuSectionManager.swift
//  GoogleMapTutorial
//
//  Created by Kang Mingu on 2021/02/15.
//

import UIKit

enum SideMenuSectionType: Int {
    
    /// 참여알림
    case notificationGuide = 0
    /// 주차장 안내
    case parkinglotGuide
    /// 정기권 신청
    case seasonTicketGuide
    /// 미납주차요금
    case nonPaymentGuide
    
    static var count: Int {
        self.nonPaymentGuide.rawValue + 1
    }
    
    var title: String {
        switch self {
        case .notificationGuide: return "title1"
        case .parkinglotGuide: return "title2"
        case .seasonTicketGuide: return "title3"
        case .nonPaymentGuide: return "title4"
        }
    }
    
    var menuNames: [String] {
        switch self {
        case .notificationGuide: return ["공지사항", "묻고 답하기", "자주 묻는 질문"]
        case .parkinglotGuide: return ["주차장 소개", "주차장 안내", "주차장 요금안내"]
        case .seasonTicketGuide: return ["정기권 신청안내", "정기권 조회/납부", "정기권 대기신청"]
        case .nonPaymentGuide: return ["미납 주차요금 납부안내", "미납 조회/납부", "미납 납부내역"]
        }
    }
    
    var viewControllers: [AnyObject] {
        switch self {
        case .notificationGuide: return [UIView(), UIView(), UIView()]
        case .parkinglotGuide: return [UIView(), UIView(), UIView()]
        case .seasonTicketGuide: return [UIView(), UIView(), UIView()]
        case .nonPaymentGuide: return [UIView(), UIView(), UIView()]
        }
    }
    
    var isCheckLogins: [Bool] {
        switch self {
        case .notificationGuide: return [false, false, false]
        case .parkinglotGuide: return [false, false, false]
        case .seasonTicketGuide: return [false, false, false]
        case .nonPaymentGuide: return [false, false, false]
        }
    }
    
    var isExpand: Bool {
        switch self {
        case .notificationGuide: return true
        case .parkinglotGuide: return false
        case .seasonTicketGuide: return false
        case .nonPaymentGuide: return false
        }
    }
    
}
