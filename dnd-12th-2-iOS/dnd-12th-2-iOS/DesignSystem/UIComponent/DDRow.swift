//
//  DDRow.swift
//  dnd-12th-2-iOS
//
//  Created by Allie on 2/5/25.
//

import SwiftUI

struct DDRow: View {
    let title: String
    let width: CGFloat
    let height: CGFloat
    let isSelected: Bool

    init(title: String,
         width: CGFloat = 343,
         height: CGFloat = 60,
         isSelected: Bool = false) {
        self.title = title
        self.width = width
        self.height = height
        self.isSelected = isSelected
    }
    
    var body: some View {
        HStack {
            Text(title)
                .font(.pretendard(size: 16, weight: .medium))
                .foregroundColor(isSelected ? .purple500 : .gray700)
            Spacer()
            if isSelected {
                Image("iconCheck")
                    .resizable()
                    .frame(width: 20, height: 20)
                    .transition(.opacity)
            }
        }
        .padding(.horizontal, 12)
        .frame(width: width, height: height)
        .background(isSelected ? Color.purple50 : Color.gray50)
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(isSelected ? Color.purple500 : Color.clear, lineWidth: 2)
        )
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .animation(.easeInOut, value: isSelected)
    }
}
