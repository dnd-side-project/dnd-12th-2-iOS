//
//  View+.swift
//  dnd-12th-2-iOS
//
//  Created by 권석기 on 2/10/25.
//
import SwiftUI

extension View {
    @ViewBuilder func hidden(_ shouldHide: Bool) -> some View {
        self
        .opacity(shouldHide ? 0 : 1)
        .disabled(shouldHide)
    }
}
