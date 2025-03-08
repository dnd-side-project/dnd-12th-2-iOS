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
    @State var isScrolling = false
    var body: some View {
        WithPerceptionTracking {
            VStack(spacing: 0) {
                CalendarView(store: store.scope(state: \.calendar,
                                                action: \.calendar))
                PlanListVIew(isScrolling: $isScrolling,
                             store: store.scope(state: \.fetchPlan,
                                                action: \.fetchPlan))
                .padding(.horizontal, -16)
                .background(Color.customBackground)
            }
            .navigationBar(center: {
                HomeNavigation()
            })
            .overlay(alignment: .bottomTrailing, content: {
                CTAButton(isScrolling: isScrolling) {
                    store.send(.addPlanButtonTapped)
                }
                .offset(y: -10)
                .padding(.horizontal, 16)
            })
            .bottomSheet($store.isShowMenu) {
                VStack {
                    MenuItem()
                }
            }
        }
    }
}

extension HomeView {
    private func HomeNavigation() -> some View {
        HStack {
            DDBackButton(action: {
                store.send(.backButtonTapped)
            })
            Spacer()
            
            Text(store.goalTitle)
                .bodyLargeSemibold()
                .foregroundStyle(Color.gray900)
                .lineLimit(1)
            
            Spacer()
            
            Button(action: {
                store.send(.showMenu)
            }, label: {
                Image("menuIcon")
            })
        }
    }
    
    private func MenuItem() -> some View {
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
