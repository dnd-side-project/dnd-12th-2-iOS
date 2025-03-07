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
    let action: () -> Void

    init(title: String,
         width: CGFloat = .infinity,
         height: CGFloat = 60,
         isSelected: Bool = false,
         action: @escaping () -> Void) {
        self.title = title
        self.width = width
        self.height = height
        self.isSelected = isSelected
        self.action = action
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
        .frame(maxWidth: width == .infinity ? .infinity : width, minHeight: height, maxHeight: height)
        .background(isSelected ? Color.purple50 : Color.gray50)
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(isSelected ? Color.purple500 : Color.clear, lineWidth: 2)
        )
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .animation(.easeInOut, value: isSelected)
        .onTapGesture {
            action()
        }
    }
}
