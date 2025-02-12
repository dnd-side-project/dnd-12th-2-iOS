//
//  GoalListView.swift
//  dnd-12th-2-iOS
//
//  Created by 권석기 on 2/12/25.
//

import SwiftUI

struct GoalListView: View {
    var body: some View {
        VStack(spacing: 0) {
            Text("목표")
                .font(.pretendard(size: 20, weight: .bold))
                .foregroundStyle(Color.gray900)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.top, 38)
                .padding(.horizontal, 16)
            
            ScrollView {
                LazyVStack(spacing: 16) {
                    ForEach(1...3, id: \.self) { _ in
                        DDProgessCard(title: "헬스장에서 근력 운동 30분 하기")
                    }
                }
                .padding(16)
            }
        }
    }
}

#Preview {
    GoalListView()
}
