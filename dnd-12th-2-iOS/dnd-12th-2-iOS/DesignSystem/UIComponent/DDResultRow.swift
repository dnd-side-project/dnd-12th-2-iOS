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
    case ready
    
    var image: Image {
        switch self {
        case .success: return Image("iconSuccess")
        case .fail: return Image("iconFail")
        case .ready: return Image("iconReady")
        }
    }
    
    var backgroundColor: Color {
        switch self {
        case .success: return .gray50
        case .fail: return .gray50
        case .ready: return .purple50
        }
    }
    
    var title: String {
        switch self {
        case .success: return "12:28 ~ 16:28"
        case .fail: return "12:28 ~ 16:28"
        case .ready: return "12:28 ~ 16:28 실행하셨나요?"
        }
    }
    
    var titleColor: Color {
        switch self {
        case .success: return .gray500
        case .fail: return .gray500
        case .ready: return .purple500
        }
    }
}

struct DDResultRow: View {
    let result: ResultType
    let title: String
    let action: () -> Void
    
    init(result: ResultType,
         title: String,
         action: @escaping () -> Void) {
        self.result = result
        self.title = title
        self.action = action
    }
    
    var body: some View {
        VStack {
            HStack(spacing: 0) {
                result.image
                    .resizable()
                    .scaledToFit()
                    .frame(width: 40, height: 40)
                    .padding(.trailing, 12)
                    .onTapGesture {
                        action()
                    }
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
