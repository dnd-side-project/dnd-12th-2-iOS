//
//  DDProgessCard.swift
//  dnd-12th-2-iOS
//
//  Created by 권석기 on 2/7/25.
//

import SwiftUI

struct DDProgessCard: View {
    let title: String
    let value: Double
    let action: () -> Void
    
    var body: some View {
        VStack {
            VStack(spacing: 12) {
                HStack {
                    Text(title)
                        .font(.pretendard(size: 16, weight: .semibold), lineHeight: 24)
                        .foregroundStyle(Color.gray900)
                    Spacer()
                    Button(action: {}, label: {
                        Image("iconRight")
                    })
                }
                
                VStack {
                    VStack(spacing: 8) {
                        Text("계획 완료율")
                            .font(.pretendard(size: 14, weight: .medium))
                            .foregroundStyle(Color.gray600)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        HStack(spacing: 12) {
                            LinearProgressView(shape: .capsule, value: value)
                                .frame(height: 12)
                            
                            Text("\(Int(value * 100))%")
                                .font(.pretendard(size: 12, weight: .bold), lineHeight: 14)
                                .foregroundStyle(Color.purple500)
                        }
                    }
                    .padding(12)
                }
                .background(Color.white)
                .cornerRadius(12)
            }
            .padding(16)
        }
        .background(Color.gray50)
        .cornerRadius(12)
    }
}

struct LinearProgressView<Shape: SwiftUI.Shape>: View {
    var shape: Shape
    let value: Double
    
    var body: some View {
        VStack {
            shape.fill(.gray50)
                .overlay(alignment: .leading) {
                    GeometryReader { proxy in
                        shape.fill(Color.purple500)
                            .frame(width: proxy.size.width * value)
                    }
                }
        }
        .animation(.easeInOut, value: value)
    }
}

//#Preview {
//    DDProgessCard(title: "")
//}
