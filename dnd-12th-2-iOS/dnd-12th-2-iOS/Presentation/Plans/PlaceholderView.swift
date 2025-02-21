//
//  PlaceholderView.swift
//  dnd-12th-2-iOS
//
//  Created by 권석기 on 2/19/25.
//

import SwiftUI

struct PlaceholderView: View {
    let imageName: String
    let action: () -> Void
    
    
    var body: some View {
        VStack {
            Spacer()
            VStack(spacing: 0) {
                Image(imageName)
                if imageName == "placeholderImage" {
                    Text("이만큼이나 넓은 가능성이 열려 있어요")
                        .font(.pretendard(size: 14, weight: .medium), lineHeight: 21)
                        .foregroundStyle(Color.gray900)
                        .padding(.top, 16)
                    HStack(spacing: 0) {
                        Text("계획을 추가")
                            .font(.pretendard(size: 14, weight: .bold))
                            .foregroundStyle(Color.gray900)
                        Text("해 공간을 채우고 목표를 향해 나아가 보세요!")
                            .font(.pretendard(size: 14, weight: .medium))
                            .foregroundStyle(Color.gray900)
                    }
                } else {
                    Text("아직도 많은 가능성이 남아있어요")
                        .font(.pretendard(size: 14, weight: .medium), lineHeight: 21)
                        .foregroundStyle(Color.gray900)
                        .padding(.top, 16)
                    HStack(spacing: 0) {
                        Text("계획을 추가")
                            .font(.pretendard(size: 14, weight: .bold))
                            .foregroundStyle(Color.gray900)
                        Text("해 목표를 향해 나아가 보세요!")
                            .font(.pretendard(size: 14, weight: .medium))
                            .foregroundStyle(Color.gray900)
                    }
                }
                
                
                DDFloatingButton(action: action)
                    .padding(.top, 8)
            }
            Spacer()
        }
        .frame(maxWidth: .infinity)
        .background(Color.gray50)
        .cornerRadius(12)
    }
}

//#Preview {
//    PlaceholderView()
//}
