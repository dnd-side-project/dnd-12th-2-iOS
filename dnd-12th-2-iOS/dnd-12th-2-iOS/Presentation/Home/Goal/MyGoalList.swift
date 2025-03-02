//
//  MyGoalList.swift
//  dnd-12th-2-iOS
//
//  Created by 권석기 on 3/2/25.
//

import SwiftUI
import ComposableArchitecture

struct MyGoalList: View {
    
    var body: some View {
        WithPerceptionTracking {
            VStack(spacing: 0) {
                HStack {
                    Text("목표")
                        .headingStyle3()
                        .foregroundStyle(Color.gray900)
                    Spacer()
                }
                
                ScrollView(showsIndicators: false) {
                    LazyVStack(spacing: 16) {
                        ForEach(1...3, id: \.self) { item in
                            DDProgessCard(title: "", value: 0, action: {})
                        }
                    }
                }
                .padding(.top, 16)
            }
        }
    }
}

//#Preview {
//    MyGoalList()
//}
