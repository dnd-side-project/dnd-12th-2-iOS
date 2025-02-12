//
//  ContentView.swift
//  dnd-12th-2-iOS
//
//  Created by Allie on 1/22/25.
//

import SwiftUI
import ComposableArchitecture

struct ContentView: View {
    @State private var isLaunch: Bool = true
    @State var text = ""
    @State var path = NavigationPath()
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
    
    var body: some View {
        ZStack {
            TabView(selection: $selection) {
                NavigationStack {
                    HomeView()
                }
                .tag(Tab.home)
                NavigationStack {
                    
                }
                .tag(Tab.statistics)
                NavigationStack {
                    
                }
                .tag(Tab.profile)
            }
            
            VStack(spacing: 0) {
                Spacer()
                tabBar
            }
        }
    }
    
    var tabBar: some View {
        VStack(spacing: 0) {
            Divider()
                .background(.gray100)
            HStack {
                ForEach(Tab.allCases, id: \.self) { tab in
                    Spacer()
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
                    }
                    Spacer()
                }
            }
            .frame(height: 61)
            .frame(maxWidth: .infinity)
            .background(Color.white)
        }
    }
}

#Preview {
    ContentView()
}
