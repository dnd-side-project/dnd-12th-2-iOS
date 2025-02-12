//
//  DDFeedbackRow.swift
//  dnd-12th-2-iOS
//
//  Created by Allie on 2/11/25.
//

import SwiftUI

enum FeedbackType {
    case success
    case fail
    
    var arrow: Image {
        switch self {
        case .success: return Image("iconArrow")
        case .fail: return Image("iconArrowRed")
        }
    }
    
    var image: Image {
        switch self {
        case .success: return Image("iconRocket")
        case .fail: return Image("iconMagic")
        }
    }
    
    var backgroundColor: Color {
        switch self {
        case .success: return .white
        case .fail: return .purple50
        }
    }
    
    var title: String {
        switch self {
        case .success: return "성공"
        case .fail: return "실패"
        }
    }
    
    var titleColor: Color {
        switch self {
        case .success: return .purple500
        case .fail: return .purple700
        }
    }
}

struct DDFeedbackRow: View {
    let result: FeedbackType
    let title: String
    let width: CGFloat
    
    init(result: FeedbackType,
         title: String,
         width: CGFloat = 343) {
        self.result = result
        self.title = title
        self.width = width
    }
    
    var body: some View {
        HStack(alignment: .center) {
            result.arrow
                .resizable()
                .scaledToFit()
                .frame(width: 10, height: 26)
                .padding(.trailing, 17)
                .padding(.leading, 25)
            
            HStack {
                result.image
                    .resizable()
                    .scaledToFit()
                    .frame(width: 16, height: 16)
                    .padding(.trailing, 4)
                
                Text(title)
                    .font(.pretendard(size: 12, weight: .medium))
                    .foregroundStyle(result.titleColor)
                    .lineLimit(2)
                    .multilineTextAlignment(.leading)
            }
            .padding(.vertical, 5)
            .padding(.horizontal, 8)
            .background(result.backgroundColor)
            .clipShape(.capsule)
            Spacer()
        }
        .frame(width: width)
    }
}
