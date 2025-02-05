//
//  DDResultRow.swift
//  dnd-12th-2-iOS
//
//  Created by Allie on 2/6/25.
//

import SwiftUI

enum ResultType {
    case success
    case fail
    
    var image: Image {
        switch self {
        case .success: return Image("iconSuccess")
        case .fail: return Image("iconFail")
        }
    }
    
    var backgroundColor: Color {
        switch self {
        case .success: return .purple100
        case .fail: return .gray50
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
        case .fail: return .red
        }
    }
}

struct DDResultRow: View {
    let result: ResultType
    let title: String
    let width: CGFloat
    let height: CGFloat
    
    init(result: ResultType,
         title: String,
         width: CGFloat = 343,
         height: CGFloat = 72) {
        self.result = result
        self.title = title
        self.width = width
        self.height = height
    }
    
    var body: some View {
        HStack() {
            result.image
                .resizable()
                .scaledToFit()
                .frame(width: 40, height: 40)
                .padding(.trailing, 12)
                .padding(.leading, 16)
            VStack(alignment: .leading) {
                Text(result.title)
                    .font(.pretendard(size: 12, weight: .medium))
                    .foregroundStyle(result.titleColor)
                    .padding(.bottom, 1)
                Text(title)
                    .font(.pretendard(size: 14, weight: .semibold))
                    .foregroundStyle(.gray900)
            }
            Spacer()
        }
        .frame(width: width, height: height)
        .background(result.backgroundColor)
        .cornerRadius(12)
    }
}
