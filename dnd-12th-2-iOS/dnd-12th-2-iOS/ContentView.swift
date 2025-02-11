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
    var body: some View {
        NavigationStack(path: $path) {
            ScrollView {
                VStack {
                    DDGoal(title: "오픽 AL받기", action: {})
                    Text("DatePicker")
                        .font(.title)
                    Button(action: {
                        path.append("Onboarding")
                    }, label: {
                        Text("Go to onboarding")
                    })
                    Text("DatePicker")
                        .font(.title)
                    DDatePicker()
                    DDProgessCard(title: "10키로 감량 다이어트")
                    Text("Progress")
                        .font(.title)
                    Text("Calendar")
                        .font(.title)
                    DDWeekView()
                    Text("Description")
                        .font(.title)
                    Text("TextField")
                        .font(.title)
                    DDTextField(text: $text)
                    Text("TextField")
                        .font(.title)
                    DDDscription(content: "실행 장소와 방법을 차분히 생각해보고 정리해보세요.")
                }
                .padding()
            }
            .navigationBar(left: {
                Image(.appLogo)
            }, right: {
                HStack {
                    Image(.iconChart)
                    Image(.iconUser)
                }
            })
            .navigationDestination(for: String.self) { screenName in
                if screenName == "Onboarding" {
                    OnboardingView(store:  Store(initialState: OnboardingFeature.State()) {
                        OnboardingFeature()
                    })
                }
            }
        }
        
    }
}

//#Preview {
//    ContentView()
//}
