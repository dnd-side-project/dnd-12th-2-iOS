//
//  DDNavigationView.swift
//  dnd-12th-2-iOS
//
//  Created by 권석기 on 2/7/25.
//

import SwiftUI

struct DDNavigationModifier<C, L, R>: ViewModifier where C: View, L: View, R: View {
    let center: (() ->C)?
    let left: (() -> L)?
    let right: (() -> R)?
    
    public init(center: (() -> C)? = {EmptyView()},
                left: (()-> L)? = {EmptyView()},
                right: (()-> R)? = {EmptyView()}) {
        self.center = center
        self.left = left
        self.right = right
    }
    
    public func body(content: Content) -> some View {
        VStack {
            ZStack {
                HStack(spacing: 0) {
                    left?()
                    Spacer()
                    right?()
                }
                .padding(.horizontal, 16)
                .frame(maxWidth: .infinity)
                
                HStack {
                    Spacer()
                    center?()
                    Spacer()
                }
            }
            .frame(height: 48)
            
            Spacer(minLength: 0)
            
            content
            
            Spacer(minLength: 0)
        }
        .background(.white)
        .navigationBarHidden(true)
    }
}

extension View {
    func navigationBar<C, L, R> (
        center: @escaping (() -> C),
        left: @escaping (() -> L),
        right: @escaping (() -> R)
    ) -> some View where C: View, L: View, R: View {
        modifier(DDNavigationModifier(center: center, left: left, right: right))
    }
    
    func navigationBar<C, R> (
        center: @escaping (() -> C),
        right: @escaping (() -> R)
    ) -> some View where C: View, R: View {
        modifier(DDNavigationModifier(center: center, right: right))
    }
    
    func navigationBar<C, L> (
        center: @escaping (() -> C),
        left: @escaping (() -> L)
    ) -> some View where C: View, L: View {
        modifier(DDNavigationModifier(center: center, left: left))
    }
    
    func navigationBar<C> (
        center: @escaping (() -> C)
    ) -> some View where C: View {
        modifier(DDNavigationModifier(center: center))
    }
    
    func navigationBar<L> (
        left: @escaping (() -> L)
    ) -> some View where L: View {
        modifier(DDNavigationModifier(left: left))
    }
    
    func navigationBar<R> (
        right: @escaping (() -> R)
    ) -> some View where R: View {
        modifier(DDNavigationModifier(right: right))
    }
    
    func navigationBar<L, R> (
        left: @escaping (() -> L),
        right: @escaping (() -> R)
    ) -> some View where L: View, R: View{
        modifier(DDNavigationModifier(left: left, right: right))
    }
}
