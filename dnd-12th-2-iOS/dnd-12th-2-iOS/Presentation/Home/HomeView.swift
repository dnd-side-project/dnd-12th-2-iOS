//
//  HomeView.swift
//  dnd-12th-2-iOS
//
//  Created by 권석기 on 2/12/25.
//

import SwiftUI
import ComposableArchitecture

struct HomeView: View {
    @State var isShowSheet = false
    var body: some View {
        WithPerceptionTracking {
            Spacer()
                .frame(height: 14)
            DDWeekView()
                .padding(.horizontal, 16)
            Divider()
                .background(Color.gray200)
            Spacer()
                .frame(height: 16)
            
            ScrollView {
                LazyVStack(spacing: 16) {
                    ForEach(0...10, id: \.self) { offset in
                        VStack(spacing: 16) {
                            if offset != 0 {
                                DDFeedbackRow(result: .success, title: "다음에는 계획을 더 구체적으로 세워봐요!")
                            }
                            DDResultRow(result: .success, title: "오픽 신청하기")
                        }
                    }
                    Spacer()
                        .frame(height: 16)
                }
                .padding(.horizontal, 16)
            }
            .overlay(alignment: .bottomTrailing, content: {
                DDFloatingButton()
                    .offset(x: -16, y: -25)
            })
        }
        .bottomSheet(isPresented: $isShowSheet, content: {
            GoalListView()
        })
        .navigationBar(left: {
            DDGoal(title: "오픽 AL받기", action: {
                isShowSheet = true
            })
        }, right: {
            Button(action: {}, label: {
                Text("더보기")
                    .font(.pretendard(size: 14, weight: .semibold))
                    .foregroundStyle(Color.purple700)
            })
        })
    }
}

#Preview {
    HomeView()
}
struct ClearBackgroundView: UIViewRepresentable {
    func makeUIView(context: Context) -> UIView {
        return InnerView()
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {
    }
    
    private class InnerView: UIView {
        override func didMoveToWindow() {
            super.didMoveToWindow()
            
            superview?.superview?.backgroundColor = .clear
        }
        
    }
}
