//
//  PlanListVIew.swift
//  dnd-12th-2-iOS
//
//  Created by 권석기 on 3/2/25.
//

import SwiftUI

struct PlanListVIew: View {
    let list: [[Int]] = [[1, 2, 3], [4, 5, 6], [7, 8], [9, 10, 11, 12]]
    var body: some View {
        ScrollViewReader { proxy in
            ScrollView(showsIndicators: false) {
                LazyVStack(spacing: 24) {
                    ForEach(0...3, id: \.self) { index in
                        Text("2025.03.02")
                            .bodyMediumMedium()
                            .alignmentLeading()
                            .foregroundStyle(Color.gray900)
                        ForEach(list[index], id: \.self) { _ in
                            LazyVStack(spacing: 16) {
                                DDResultRow(action: {})
                            }
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    PlanListVIew()
}
