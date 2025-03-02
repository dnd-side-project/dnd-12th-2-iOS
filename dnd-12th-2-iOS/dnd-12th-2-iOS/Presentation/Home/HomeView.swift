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
    @State var isPresented = false
    
    var body: some View {
        WithPerceptionTracking {
            NavigationStack(path: $store.scope(state: \.path, action: \.path)) {
                VStack {
                    CalendarView()
                    PlanListVIew()
                }
                .navigationBar(center: {
                    navigationView
                })
                .bottomSheet($isPresented) {
                    ScrollView {
                        VStack {
                          
                        }
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
                
            }, label: {
                Image("menuIcon")
            })
            Spacer()
            // center
            
            Button(action: {
                isPresented = true
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
}

//#Preview {
//    HomeView()
//}
