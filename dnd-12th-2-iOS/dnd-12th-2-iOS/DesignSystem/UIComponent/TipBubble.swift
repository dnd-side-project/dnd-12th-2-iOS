//
//  TipBubble.swift
//  dnd-12th-2-iOS
//
//  Created by 권석기 on 3/7/25.
//

import SwiftUI

struct TipBubble: View {
    @State var isHidden = true
    @State var scale = 0.8
    var body: some View {
        VStack {
            if !isHidden {
                HStack(spacing: 8) {
                    Image("iconLight")
                    VStack(spacing: 0) {
                        HStack {
                            Text("아직 많은 가능성이 남아있어요")
                                .bodyLargeSemibold()
                                .foregroundStyle(Color.gray50)
                            Spacer()
                        }
                        HStack {
                            Text("작은 변화부터 시작해보는 건 어떨까요?")
                                .bodyMediumRegular()
                                .foregroundStyle(Color.gray50)
                            Spacer()
                        }                        
                    }
                }
                .padding(.bottom, 15)
                .padding(.vertical, 14)
                .padding(.horizontal, 20)
                .background(Color.gray900)
                .clipShape(TipBubbleShape())
                .foregroundColor(.white)
                .scaleEffect(scale)
                
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                withAnimation {
                    isHidden = false
                }
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                withAnimation(.spring(response: 0.5, dampingFraction: 0.7, blendDuration: 0.25)) {
                    scale = 1.0
                }
            }
        }
    }
}

#Preview {
    TipBubble()
}

struct TipBubbleShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        let cornerRadius: CGFloat = 12
        
        path.addRoundedRect(
            in: CGRect(x: 0, y: 0, width: rect.width, height: rect.height - 15),
            cornerSize: CGSize(width: cornerRadius, height: cornerRadius)
        )
        
        path.move(to: CGPoint(x: rect.width * 0.8, y: rect.height - 15))
        path.addLine(to: CGPoint(x: rect.width * 0.8 + 9, y: rect.height))
        path.addLine(to: CGPoint(x: rect.width * 0.8 + 18, y: rect.height - 15))
        path.closeSubpath()
        return path
    }
}
