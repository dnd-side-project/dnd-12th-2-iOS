//
//  Plan.swift
//  dnd-12th-2-iOS
//
//  Created by 권석기 on 2/19/25.
//

import SwiftUI

struct PlanGroup: Hashable {
    let startDate: Date
    let plans: [Plan]
}

struct Plan: Hashable {
    let planId: Int
    let title: String
    let status: String
    let guide: String
    let startDate: String
    let endDate: String
    let completedDate: String?
    
    var resultType: ResultType {
        switch status {
        case "success":
            .success
        case "failure":
            .failure
        default:
            .ready
        }
    }
    
    var feedbackType: FeedbackType {
        switch status {
        case "success":
            .success
        case "failure":
            .failure
        default:
            .none
        }
    }
    
    enum ResultType {
        case success
        case failure
        case ready
        
        var image: Image {
            switch self {
            case .success: return Image("iconSuccess")
            case .failure: return Image("iconFail")
            case .ready: return Image("iconReady")
            }
        }
        
        var backgroundColor: Color {
            switch self {
            case .success: return .gray50
            case .failure: return .gray50
            case .ready: return .purple50
            }
        }
        
        var title: String {
            switch self {
            case .success: return "12:28 ~ 16:28"
            case .failure: return "12:28 ~ 16:28"
            case .ready: return "12:28 ~ 16:28 실행하셨나요?"
            }
        }
        
        var titleColor: Color {
            switch self {
            case .success: return .gray500
            case .failure: return .gray500
            case .ready: return .purple500
            }
        }
    }
    
    enum FeedbackType {
        case success
        case failure
        case none
        
        var arrow: Image {
            switch self {
            case .success: return Image("iconArrow")
            case .failure: return Image("iconArrowRed")
            case .none: return Image("iconArrowGray")
            }
        }
        
        var image: Image {
            switch self {
            case .success: return Image("iconRocket")
            case .failure: return Image("iconMagic")
            case .none: return Image("")
            }
        }
        
        var backgroundColor: Color {
            switch self {
            case .success: return .white
            case .failure: return .purple50
            case .none: return .white
            }
        }
        
        var title: String {
            switch self {
            case .success: return "성공"
            case .failure: return "실패"
            case .none: return ""
            }
        }
        
        var titleColor: Color {
            switch self {
            case .success: return .purple500
            case .failure: return .purple700
            case .none: return .white
            }
        }
    }
}
