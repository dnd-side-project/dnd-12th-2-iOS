//
//  AnyTransaction+.swift
//  dnd-12th-2-iOS
//
//  Created by 권석기 on 2/9/25.
//
import SwiftUI

extension AnyTransition {
    static var backslide: AnyTransition {
        AnyTransition.asymmetric(
            insertion: .move(edge: .trailing),
            removal: .move(edge: .leading))}
    
    static var forwardSlide: AnyTransition {
        AnyTransition.asymmetric(
            insertion: .move(edge: .leading),
            removal: .move(edge: .trailing))}
}

