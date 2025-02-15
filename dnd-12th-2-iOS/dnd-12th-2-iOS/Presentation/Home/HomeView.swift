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
    @State var isShowMenu = false
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
            
            ScrollView(showsIndicators: false) {
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
        .bottomSheet(isPresented: $isShowSheet, height: UIScreen.screenHeight * 0.75, content: {
            GoalListView()
        })
        .bottomSheet(isPresented: $isShowMenu, height: 210, content: {
            VStack(spacing: 34) {
                Button(action: {}, label: {
                    HStack(spacing: 8) {
                        Image("iconFlag")
                        Text("목표 달성")
                            .font(.pretendard(size: 16, weight: .semibold), lineHeight: 24)
                            .foregroundStyle(Color.gray900)
                        Spacer()
                    }
                })
                
                Button(action: {}, label: {
                    HStack(spacing: 8) {
                        Image("iconEdit")
                        Text("목표 수정")
                            .font(.pretendard(size: 16, weight: .semibold), lineHeight: 24)
                            .foregroundStyle(Color.gray900)
                        Spacer()
                    }
                })
                
                Button(action: {}, label: {
                    HStack(spacing: 8) {
                        Image("iconTrash")
                        Text("삭제하기")
                            .font(.pretendard(size: 16, weight: .semibold), lineHeight: 24)
                            .foregroundStyle(Color.gray900)
                        Spacer()
                    }
                })
            }
            .padding(.leading, 23)
            .padding(.vertical, 30)
        })
        .navigationBar(left: {
            DDGoal(title: "오픽 AL받기", action: {
                isShowSheet = true
            })
        }, right: {
            Button(action: {
                isShowMenu = true
            }, label: {
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
