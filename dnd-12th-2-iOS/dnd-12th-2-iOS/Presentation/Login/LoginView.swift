//
//  LoginView.swift
//  dnd-12th-2-iOS
//
//  Created by 권석기 on 2/28/25.
//

import SwiftUI
import ComposableArchitecture
import AuthenticationServices

struct LoginView: View {
    @Perception.Bindable var store: StoreOf<LoginNavigation>
    @State var tabIndex = 0
    var body: some View {
        WithPerceptionTracking {
            NavigationStack(path: $store.scope(state: \.path, action: \.path)) {
                VStack {
                    Spacer()
                    
                    TabView(selection: $tabIndex) {
                        VStack(spacing: 0) {
                            Spacer()
                            Rectangle()
                                .frame(width: 200, height: 200)
                                .foregroundStyle(Color.gray)
                            
                            Text("빠르게 실패하세요")
                                .headingStyle2()
                                .foregroundStyle(Color.gray900)
                                .padding(.top, 25)
                            
                            Text("다음엔 할 일을 완수하도록 가이드를 제공해요 실패를 목표를 구체화하는 과정으로 바꿔봐요")
                                .bodyXLargeMedium()
                                .foregroundStyle(Color.gray600)
                                .padding(.top, 16)
                        }
                        .tag(0)
                        
                        VStack(spacing: 0) {
                            Spacer()
                            Rectangle()
                                .frame(width: 200, height: 200)
                                .foregroundStyle(Color.gray)
                            
                            Text("자주 기록해요")
                                .headingStyle2()
                                .foregroundStyle(Color.gray900)
                                .padding(.top, 25)
                            
                            Text("할 일을 완료했는지 못했는지 \n기록할 수 있어요")
                                .bodyXLargeMedium()
                                .foregroundStyle(Color.gray600)
                                .padding(.top, 16)
                        }
                        .tag(1)
                        
                        VStack(spacing: 0) {
                            Spacer()
                            Rectangle()
                                .frame(width: 200, height: 200)
                                .foregroundStyle(Color.gray)
                            
                            Text("습관을 들여요")
                                .headingStyle2()
                                .foregroundStyle(Color.gray900)
                                .padding(.top, 25)
                            
                            Text("할 일을 완료하면")
                                .bodyXLargeMedium()
                                .foregroundStyle(Color.gray600)
                                .padding(.top, 16)
                        }
                        .tag(2)
                    }
                    .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                    
                    HStack(spacing: 8) {
                        ForEach(0..<3, id: \.self) { index in
                            Group {
                                if index == tabIndex {
                                    Circle()
                                        .frame(width: 8, height: 8)
                                        .foregroundColor(.black)
                                } else {
                                    Circle()
                                        .frame(width: 8, height: 8)
                                        .foregroundColor(Color.gray50)
                                }
                            }
                        }
                    }
                    .padding(.top, 36)
                    
                    Spacer()
                    
                    DDButton(image: Image("iconApple"),
                             imageSize: 20,
                             title: "애플 로그인",
                             font: .pretendard(size: 16, weight: .medium),
                             backgroundColor: .black,
                             cornerRadius: 12) {}
                        .overlay {
                            SignInWithAppleButton(
                                onRequest: { request in
                                    request.requestedScopes = [.fullName, .email]},
                                onCompletion: { result in
                                    switch result {
                                    case let .success(authorization):
                                        store.send(.appleLoginButtonTapped(authorization))
                                        break
                                    case .failure:
                                        break
                                    }
                                }
                            )
                            .blendMode(.overlay)
                        }
                        .padding(.top, 53)
                        .padding(.bottom, 12)
                }
                .padding(.horizontal, 20)
            } destination: { store in
                switch store.case {
                case let .onboarding(store):
                    OnboardingView(store: store)
                case let .setFirstGoal(store):
                    FirstGoalView(store: store)
                }
            }
        }
    }
}

//#Preview {
//    LoginView()
//}
