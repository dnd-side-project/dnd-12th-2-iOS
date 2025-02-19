//
//  DDFeedbackRow.swift
//  dnd-12th-2-iOS
//
//  Created by Allie on 2/11/25.
//

import SwiftUI

struct DDFeedbackRow: View {
    let result: Plan.FeedbackType
    let title: String
    let width: CGFloat
    
    init(result: Plan.FeedbackType,
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
