//
//  DDButton.swift
//  dnd-12th-2-iOS
//
//  Created by Allie on 2/5/25.
//

import SwiftUI

struct DDButton: View {
    let image: Image?
    let title: String
    let font: Font
    let backgroundColor: Color
    let textColor: Color
    let width: CGFloat
    let height: CGFloat
    let cornerRadius: CGFloat
    let action: () -> Void
    
    init(image: Image? = nil,
         title: String = "다음",
         font: Font = .pretendard(size: 16, weight: .semibold),
         backgroundColor: Color = .gray100,
         textColor: Color = .gray500,
         width: CGFloat = 343,
         height: CGFloat = 54,
         cornerRadius: CGFloat = 12,
         action: @escaping () -> Void) {
        self.image = image
        self.title = title
        self.font = font
        self.backgroundColor = backgroundColor
        self.textColor = textColor
        self.width = width
        self.height = height
        self.cornerRadius = cornerRadius
        self.action = action
    }
    
    var body: some View {
        Button(action: action) {
            HStack {
                if let image = image {
                    image
                        .resizable()
                        .scaledToFit()
                        .foregroundStyle(.white)
                        .frame(width: 12, height: 12)
                }
                Text(title)
                    .font(font)
                    .foregroundStyle(textColor)

            }
            .frame(width: width, height: height)
            .background(backgroundColor)
            .cornerRadius(cornerRadius)
        }
    }
}
