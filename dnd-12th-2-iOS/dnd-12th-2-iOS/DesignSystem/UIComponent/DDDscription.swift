//
//  DDDscription.swift
//  dnd-12th-2-iOS
//
//  Created by 권석기 on 2/7/25.
//

import SwiftUI

struct DDDscription: View {
    let content: String
    
    var body: some View {
        VStack {
            HStack(spacing:0) {
                Image(.iconInfo)
                Spacer()
                    .frame(width: 8)
                Text(content)
                    .font(.pretendard(size: 12, weight: .regular))
                    .foregroundStyle(Color.purple500)
                
                Spacer()
            }
            .padding(12)
        }
        .background(Color.purple50)
        .cornerRadius(8)
    }
}

#Preview {
    DDDscription(content: "dsdf")
}
