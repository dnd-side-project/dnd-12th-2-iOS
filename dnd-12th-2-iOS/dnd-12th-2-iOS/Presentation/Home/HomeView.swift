//
//  HomeView.swift
//  dnd-12th-2-iOS
//
//  Created by 권석기 on 2/28/25.
//

import SwiftUI
import ComposableArchitecture

struct HomeView: View {
    @Perception.Bindable var store: StoreOf<HomeNavigation>
    
    var body: some View {
        WithPerceptionTracking {
            NavigationStack(path: $store.scope(state: \.path, action: \.path)) {
                VStack(spacing: 0) {
                    CalendarView(store: store.scope(state: \.calendar,
                                                    action: \.calendar))
                    PlanListVIew(store: store.scope(state: \.fetchPlan,
                                                    action: \.fetchPlan))
                }
                .navigationBar(center: {
                    navigationView
                })
                .overlay(alignment: .bottomTrailing, content: {
                    DDFloatingButton {
                        
                    }
                })
                .bottomSheet($store.isShowMenu) {
                    VStack {
                        menuItem
                    }
                }
                .bottomSheet($store.isShowGoalList, maxHeight: UIScreen.screenHeight * 0.75) {
                    VStack {
                        MyGoalList()
                    }
                }
            } destination: { store in
                switch store.case {
                default:
                    EmptyView()
                }
            }
        }
    }
}

extension HomeView {
    private var navigationView: some View {
        HStack {
            Button(action: {
                
            }, label: {
                DDBackButton(action: {})                    
            })
            Spacer()
            // center
            
            Text("3개월 안에 UX/UI 디자이너로 취업 취업 취업 취업")
                .bodyLargeSemibold()
                .foregroundStyle(Color.gray900)
                .lineLimit(1)
            
            Spacer()
            // right
            
            Button(action: {
                store.send(.showMenu)
            }, label: {
                Image("menuIcon")
            })
        }
    }
    
    private var menuItem: some View {
        VStack(spacing: 34) {
            HStack {
                HStack(spacing: 8) {
                    Image("iconFlag")
                    Text("목표 달성")
                        .bodyLargeSemibold()
                        .foregroundStyle(Color.gray900)
                }
                Spacer()
            }
            
            HStack {
                HStack(spacing: 8) {
                    Image("iconTrash")
                    Text("삭제하기")
                        .bodyLargeSemibold()
                        .foregroundStyle(Color.gray900)
                }
                Spacer()
            }
        }
    }
}

//#Preview {
//    HomeView()
//}
