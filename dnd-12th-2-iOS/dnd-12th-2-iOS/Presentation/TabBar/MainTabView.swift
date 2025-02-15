//
//  MainTabView.swift
//  dnd-12th-2-iOS
//
//  Created by 권석기 on 2/15/25.
//

import SwiftUI
import ComposableArchitecture

struct MainTabView: View {
    let store: StoreOf<TabFeature>
    @State private var selection: Tab = .home
    
    enum Tab: CaseIterable {
        case home, statistics, profile
        
        var title: String {
            switch self {
            case .home: return "홈"
            case .statistics: return "통계"
            case .profile: return "프로필"
            }
        }
        
        var icon: String {
            switch self {
            case .home: return "iconHome"
            case .statistics: return "iconStatistics"
            case .profile: return "iconProfile"
            }
        }
        
        var iconGray: String {
            switch self {
            case .home: return "iconHomeGray"
            case .statistics: return "iconStatisticsGray"
            case .profile: return "iconProfileGray"
            }
        }
    }
    
    var tabBar: some View {
        VStack(spacing: 0) {
            Divider()
                .background(.gray100)
            HStack {
                Spacer()
                
                ForEach(Tab.allCases, id: \.self) { tab in
                    Button {
                        selection = tab
                    } label: {
                        VStack {
                            Image(selection == tab ? tab.icon : tab.iconGray)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 24, height: 24)
                            
                            Text(tab.title)
                                .font(.pretendard(size: 10, weight: selection == tab ? .bold : .regular))
                                .foregroundStyle(selection == tab ? .purple700 : .gray400)
                        }
                        .frame(maxWidth: .infinity)
                        .contentShape(Rectangle())
                    }.buttonStyle(NoTapAnimationStyle())
                    Spacer()
                }
            }
            .frame(height: 61)
            .frame(maxWidth: .infinity)
            .background(Color.white)
        }
    }
    
    var body: some View {
        ZStack {
            TabView(selection: $selection) {
                HomeView()
                    .tag(Tab.home)
                StatisticView()
                    .tag(Tab.statistics)
                ProfileView()
                    .tag(Tab.profile)
            }
            
            VStack(spacing: 0) {
                Spacer()
                tabBar
            }
        }
    }
}

//#Preview {
//    MainTabView()
//}
struct NoTapAnimationStyle: PrimitiveButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            // Make the whole button surface tappable. Without this only content in the label is tappable and not whitespace. Order is important so add it before the tap gesture
            .contentShape(Rectangle())
            .onTapGesture(perform: configuration.trigger)
    }
}
