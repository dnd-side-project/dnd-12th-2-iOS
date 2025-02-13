//
//  BottomSheet.swift
//  dnd-12th-2-iOS
//
//  Created by 권석기 on 2/12/25.
//

import UIKit
import SwiftUI

struct BottomSheetModifier<ContentView: View>: ViewModifier {
    @Binding var isPresented: Bool
    let contentView: () -> ContentView
    
    func body(content: Content) -> some View {
        content
            .sheet(isPresented: $isPresented) {
                contentView()
                    .presentationDetents([.fraction(0.75)])
                    .presentationCornerRadius(24)
            }
    }
}

extension View {
    func bottomSheet<Content: View>(isPresented: Binding<Bool>, content: @escaping () -> Content) -> some View {
        modifier(BottomSheetModifier(isPresented: isPresented, contentView: content))
    }
}
