//
//  Plan.swift
//  dnd-12th-2-iOS
//
//  Created by 권석기 on 3/4/25.
//

import SwiftUI

enum ResultType {
    case success
    case failure
    case ready
}
struct Plan: Hashable {
    let planId: Int
    let title: String
    let status: String
    let guide: String?
    let startDate: String
    let endDate: String
    let completedDate: String?
    
    var period: String {
        return "\(startDate.toTimeFormat()) ~ \(endDate.toTimeFormat())"
    }
    
    var resultType: ResultType {
        switch status {
        case "success":
            return .success
        case "failure":
            return .failure
        default:
            return .ready
        }
    }
    
    var image: Image {
        switch resultType {
        case .success:
            Image("iconSuccess")
        case .failure:
            Image("iconFail")
        case .ready:
            Image("iconReady")
        }
    }
}
