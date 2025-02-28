//
//  MyPageView.swift
//  dnd-12th-2-iOS
//
//  Created by 권석기 on 2/28/25.
//

import SwiftUI
import ComposableArchitecture

struct MyPageView: View {
    let store: StoreOf<MyPage>
    var body: some View {
        VStack {
            Text("마이페이지")
                .font(.title)
            Button(action: {
                store.send(.logoutButtonTapped)
            }, label: {
                Text("logout")
            })
        }
    }
}

//#Preview {
//    MyPageView()
//}
