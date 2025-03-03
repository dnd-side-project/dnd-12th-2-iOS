//
//  PlanListVIew.swift
//  dnd-12th-2-iOS
//
//  Created by 권석기 on 3/2/25.
//

import SwiftUI
import ComposableArchitecture

struct PlanListVIew: View {
    let store: StoreOf<FetchPlan>
    let list: [[Int]] = [[1, 2, 3], [4, 5, 6], [7, 8], [9, 10, 11, 12]]
    var body: some View {
        ScrollViewReader { proxy in
            ScrollView(showsIndicators: false) {                
                LazyVStack(spacing: 24) {
                    ForEach(0...3, id: \.self) { index in
                        Text("2월 22일")
                            .bodyMediumMedium()
                            .alignmentLeading()
                            .foregroundStyle(Color.gray500)
                            
                        ForEach(list[index], id: \.self) { _ in
                            LazyVStack(spacing: 16) {
                                DDResultRow(action: {})
                            }
                        }
                    }
                }
                .padding(.top, 11)
            }
        }.overlay(alignment: .top) {
            Divider()
                .frame(width: UIScreen.screenWidth)
        }
    }
}

//#Preview {
//    PlanListVIew()
//}
