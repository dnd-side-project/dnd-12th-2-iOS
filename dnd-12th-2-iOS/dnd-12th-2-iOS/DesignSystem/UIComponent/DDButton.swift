//
//  DDButton.swift
//  dnd-12th-2-iOS
//
//  Created by Allie on 2/5/25.
//

import SwiftUI

struct DDButton: View {
    let isDisable: Bool
    let image: Image?
    let imageSize: CGFloat?
    let title: String
    let font: Font
    let backgroundColor: Color
    let textColor: Color
    let width: CGFloat
    let height: CGFloat
    let cornerRadius: CGFloat
    let action: () -> Void
    
    init(image: Image? = nil,
         imageSize: CGFloat? = 12,
         title: String = "다음",
         font: Font = .pretendard(size: 16, weight: .semibold),
         backgroundColor: Color = .purple500,
         textColor: Color = .white,
         width: CGFloat = .infinity,
         height: CGFloat = 54,
         cornerRadius: CGFloat = 12,
         isDisable: Bool = false,
         action: @escaping () -> Void) {
        self.image = image
        self.imageSize = imageSize
        self.title = title
        self.font = font
        self.backgroundColor = backgroundColor
        self.textColor = textColor
        self.width = width
        self.height = height
        self.cornerRadius = cornerRadius
        self.action = action
        self.isDisable = isDisable
    }
    
    var body: some View {
        Button(action: action) {
            HStack {
                if let image = image {
                    image
                        .resizable()
                        .scaledToFit()
                        .foregroundStyle(.white)
                        .frame(width: imageSize, height: imageSize)
                }
                Text(title)
                    .font(font)
                    .foregroundStyle(textColor)

            }
            .frame(maxWidth: width == .infinity ? .infinity : width, minHeight: height, maxHeight: height)
            .background(isDisable ? .gray100 : backgroundColor)
            .cornerRadius(cornerRadius)
      
        }.disabled(isDisable)
    }
}
