//
//  DDProgessCard.swift
//  dnd-12th-2-iOS
//
//  Created by 권석기 on 2/7/25.
//

import SwiftUI

struct DDProgessCard: View {
    let title: String
    
    var body: some View {
        VStack(spacing: 0) {
            VStack(spacing: 0) {
                HStack {
                    Text(title)
                        .font(.pretendard(size: 16, weight: .semibold))
                        .foregroundStyle(.gray800)
                    Spacer()
                    Image(.iconRight)
                }
                Spacer()
                    .frame(height: 8)
                VStack(spacing: 0) {
                    HStack {
                        Text("계획 성공률")
                            .font(.pretendard(size: 12, weight: .medium))
                            .foregroundStyle(Color.gray400)
                        Spacer()
                        Text("80%")
                            .font(.pretendard(size: 12, weight: .bold))
                            .foregroundStyle(Color.purple600)
                    }
                    
                    Spacer()
                        .frame(height: 4)
                    
                    LinearProgressView(shape: Capsule(), value: 0.6)
                        .frame(height: 12)
                }
            }
            .padding(.horizontal, 18)
            .padding(.vertical, 16)
        }
        .background(Color.purple50)
        .cornerRadius(12)
    }
}

struct LinearProgressView<Shape: SwiftUI.Shape>: View {
    var shape: Shape
    let value: Double
    
    var body: some View {
        VStack {
            shape.fill(.gray200)
                .overlay(alignment: .leading) {
                    GeometryReader { proxy in
                        shape.fill(Color.purple600)
                            .frame(width: proxy.size.width * value)
                    }
                }
        }
        .animation(.easeInOut, value: value)
    }
}

#Preview {
    DDProgessCard(title: "")
}
