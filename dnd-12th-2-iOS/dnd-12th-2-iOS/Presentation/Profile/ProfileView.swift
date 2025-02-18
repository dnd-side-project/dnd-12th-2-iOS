//
//  ProfileView.swift
//  dnd-12th-2-iOS
//
//  Created by 권석기 on 2/12/25.
//

import SwiftUI
import ComposableArchitecture

struct ProfileView: View {
    let store: StoreOf<ProfileNavigation>
    
    var body: some View {
        VStack {
            Text("\(store.result)")
            Button(action: {
                store.send(.tesButtonTapped)
            }) {
                Text("Network Test")
            }
            .buttonStyle(.borderedProminent)
            
            
            Button(action: {
                store.send(.logoutButtonTapped)
            }) {
                Text("Logout")
            }
            .buttonStyle(.borderedProminent)
        }
    }
}

//#Preview {
//    ProfileView()
//}
