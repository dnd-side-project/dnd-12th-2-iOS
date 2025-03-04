//
//  CustomAlert.swift
//  dnd-12th-2-iOS
//
//  Created by Allie on 3/4/25.
//

import SwiftUI

struct CustomAlert: View {
    var body: some View {
        ZStack {
            Color.black.opacity(0.4)
                .edgesIgnoringSafeArea(.all)
            
            VStack(alignment: .leading) {
                Text("목표를 달성하셨나요?")
                    .font(.pretendard(size: 18, weight: .semibold))
                    .foregroundStyle(.gray900)
                
                HStack {
                    DDButton(title: "취소",
                             font: .pretendard(size: 16, weight: .medium),
                             backgroundColor: .gray50,
                             textColor: .gray500,
                             width: 104,
                             height: 48,
                             cornerRadius: 12) {
                        
                    }
                    DDButton(title: "달성",
                             font: .pretendard(size: 16, weight: .medium),
                             backgroundColor: .purple600,
                             textColor: .white,
                             width: 104,
                             height: 48,
                             cornerRadius: 12) {
                        
                    }
                }
                .padding(.top, 24)
            }
            .padding(20)
            .background(.white)
            .cornerRadius(12)
        }
    }
}

#Preview {
    CustomAlert()
}
