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
    @Perception.Bindable var store: StoreOf<HomeNavigation>
    
    var body: some View {
        NavigationStack(path: $store.scope(state: \.path, action: \.path)) {
            WithPerceptionTracking {
                Spacer()
                    .frame(height: 14)
                DDWeekView()
                    .padding(.horizontal, 16)
                Divider()
                    .background(Color.gray200)
                Spacer()
                    .frame(height: 16)
                PlanListView(store: store.scope(state: \.plan, action: \.plan))
            }
            .onAppear {
                store.send(.viewAppear)
            }
            .bottomSheet(isPresented: $store.isShowSheet, height: UIScreen.screenHeight * 0.7, content: {
                GoalListView(store: store.scope(state: \.goal, action: \.goal))
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
                DDGoal(title: store.goal.selectedGoal.title, action: {
                    store.send(.presentSheet)
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
        } destination: { store in
            switch store.case {
            case let .completeScreen(store):
                FeedbackCompleteView(store: store)
            case let .resultScreen(store):
                FeedbackResultView(store: store)
            case let .selecteScreen(store):
                CompleteListView(store: store)
            case let .goalScreen(store):
                GoalView(store: store)
            }
        }
    }
}

//#Preview {
//    HomeView()
//}
