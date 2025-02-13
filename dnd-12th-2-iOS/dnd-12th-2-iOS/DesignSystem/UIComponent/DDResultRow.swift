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
        case .success: return .purple50
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
    
    init(result: ResultType,
         title: String) {
        self.result = result
        self.title = title
    }
    
    var body: some View {
        VStack {
            HStack(spacing: 0) {
                result.image
                    .resizable()
                    .scaledToFit()
                    .frame(width: 40, height: 40)
                    .padding(.trailing, 12)
                VStack(alignment: .leading, spacing: 0) {
                    Text(result.title)
                        .font(.pretendard(size: 12, weight: .medium), lineHeight: 14)
                        .foregroundStyle(result.titleColor)
                        .padding(.bottom, 1)
                    Text(title)
                        .font(.pretendard(size: 14, weight: .semibold), lineHeight: 24)
                        .foregroundStyle(.gray900)
                }
                Spacer()
                
                Button(action: {}, label: {
                    Image(.iconRight)
                })
            }
            .padding(.vertical, 14)
            .padding(.horizontal, 12)
        }
        .background(result.backgroundColor)
        .cornerRadius(12)
    }
}
