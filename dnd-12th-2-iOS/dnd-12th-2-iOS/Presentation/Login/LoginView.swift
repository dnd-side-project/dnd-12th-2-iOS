//
//  LoginView.swift
//  dnd-12th-2-iOS
//
//  Created by Allie on 2/9/25.
//

import SwiftUI
import ComposableArchitecture

struct LoginView: View {
    @Perception.Bindable var store: StoreOf<LoginNavigation>
    
    var body: some View {
        NavigationStack(path: $store.scope(state: \.path, action: \.path)) {
            ZStack {
                Image("imgBackground")
                    .resizable()
                    .padding(.top, 203)
                    .ignoresSafeArea()
                    .scaledToFill()
                   
                VStack(alignment: .leading) {
                    Text("할 건 많은데...\n뭐부터 해야하지?\n도달에서 도와드릴게요")
                        .font(.pretendard(size: 24, weight: .heavy))
                        .foregroundStyle(.gray900)
                        .multilineTextAlignment(.leading)
                        .lineSpacing(8)
                        .padding(.top, 122)
                        .padding(.leading, 20)
                    
                    Spacer()
                    
                    VStack {
//                        DDButton(title: "로그인없이 둘러보기",
//                                 font: .pretendard(size: 16, weight: .medium),
//                                 backgroundColor: .white,
//                                 textColor: .black,
//                                 width: 320,
//                                 height: 54,
//                                 cornerRadius: 8) {
//                            print("로그인없이 둘러보기")
//                        }
                        DDButton(image: Image("iconApple"),
                                 imageSize: 20,
                                 title: "애플 로그인",
                                 font: .pretendard(size: 16, weight: .medium),
                                 backgroundColor: .black,
                                 textColor: .white,
                                 width: 320,
                                 height: 54,
                                 cornerRadius: 8) {
                            store.send(.goToOnboading)
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.bottom, 52.5)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
        } destination: { store in
            switch store.case {                
            case let .onboadingScreen(store):
                OnboardingView(store: store)
            case let .goalScreen(store):
                GoalView(store: store)
            case let .resultScreen(store):
                GoalResultView(store: store)
            }
        }
    }
}

//#Preview {
//    LoginView()
//}
