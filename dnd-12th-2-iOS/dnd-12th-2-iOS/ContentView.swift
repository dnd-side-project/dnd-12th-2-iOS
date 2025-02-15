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
    let store: StoreOf<RootFeature>
    
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
        SwitchStore(self.store) { state in
            switch state {
            case .loginCheck:
                CaseLet(/RootFeature.State.loginCheck, action: RootFeature.Action.loginCheck) {
                    SplashView(store: $0)
                }
            case .loggedIn:
                CaseLet(/RootFeature.State.loggedIn, action: RootFeature.Action.loggedIn) { loggedInStore in
                    Text("dd")
                }
            case .loggedOut:
                CaseLet(/RootFeature.State.loggedOut, action: RootFeature.Action.loggedOut) {
                    LoginView(store: $0)
                }
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

//#Preview {
//    ContentView()
//}
