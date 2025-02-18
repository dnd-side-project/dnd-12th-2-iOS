//
//  LoginView.swift
//  dnd-12th-2-iOS
//
//  Created by Allie on 2/9/25.
//

import SwiftUI
import ComposableArchitecture
import AuthenticationServices

struct LoginView: View {
    @Perception.Bindable var store: StoreOf<LoginNavigation>
    
    var body: some View {
        WithPerceptionTracking {
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
                            DDButton(image: Image("iconApple"),
                                     imageSize: 20,
                                     title: "애플 로그인",
                                     font: .pretendard(size: 16, weight: .medium),
                                     backgroundColor: .black,
                                     textColor: .white,
                                     height: 54,
                                     cornerRadius: 8) {}
                                .overlay {
                                    SignInWithAppleButton(
                                        onRequest: { request in
                                            request.requestedScopes = [.fullName, .email]},
                                        onCompletion: { result in
                                            switch result {
                                            case let .success(authorization):
                                                store.send(.appleLoginButtonTapped(authorization))
                                            case .failure:
                                                break
                                            }
                                        }
                                    )
                                    .blendMode(.overlay)
                                }
                            
                        }
                        .frame(maxWidth: .infinity)
                        .padding(.bottom, 52.5)
                        .padding(.horizontal, 20)
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
}

//#Preview {
//    LoginView()
//}
