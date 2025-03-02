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
                    CalendarView()
                        .padding(.top, 16)
                       
                    PlanListVIew()                 
                }
                .navigationBar(center: {
                    navigationView
                })
                .overlay(alignment: .bottomTrailing, content: {
                    DDFloatingButton {
                        
                    }
                    .offset(x: -16, y: -20)
                    .shadow(color: .black.opacity(0.08), radius: 4, x: 0, y: 2)
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
                case let .myPage(store):
                    MyPageView(store: store)
                }
            }
        }
    }
}

extension HomeView {
    private var navigationView: some View {
        HStack {
            Button(action: {
                store.send(.showGoalList)
            }, label: {
                Image("menuIcon")
            })
            Spacer()
            // center
            
            Button(action: {
                store.send(.showMenu)
            }, label: {
                HStack {
                    Text("3개월 안에 UX/UI 디자이너로 취업 취업 취업 취업")
                        .bodyLargeSemibold()
                        .foregroundStyle(Color.gray900)
                        .lineLimit(1)
                    Image("downButton")
                }
            })
            
            Spacer()
            // right
            
            Button(action: {
                store.send(.goToMyPage)
            }, label: {
                Text("프로필")
                    .bodyMediumSemibold()
                    .foregroundStyle(Color.purple700)
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
                    Image("iconEdit")
                    Text("목표 수정")
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
