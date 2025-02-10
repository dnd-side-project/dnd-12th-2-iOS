//
//  LineHeight.swift
//  dnd-12th-2-iOS
//
//  Created by 권석기 on 2/10/25.
//

import SwiftUI
import UIKit

extension View {
    func font(_ font: UIFont, lineHeight: CGFloat = 0) -> some View {
        let fontHeight = font.lineHeight
        let adjustHeight = lineHeight - fontHeight
        
        return self
            .font(Font(font))
            .lineSpacing(lineHeight - font.lineHeight)
            .padding(.vertical, (adjustHeight > 0 ? adjustHeight : 0) / 2)
    }
}
