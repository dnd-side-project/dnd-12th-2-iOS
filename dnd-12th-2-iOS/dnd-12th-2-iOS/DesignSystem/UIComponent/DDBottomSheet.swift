//
//  DDBottomSheet.swift
//  dnd-12th-2-iOS
//
//  Created by 권석기 on 3/2/25.
//

import SwiftUI

struct DDBottomSheet<ContentView>: ViewModifier where ContentView: View {
    @Binding var isPresented: Bool
    var maxHeight: CGFloat?
    @GestureState var translation: CGFloat = 0
    @State private var offset: CGFloat = 0
    @State private var dynamicHeight: CGFloat = 300
    @State private var lastDragHeight: CGFloat = 0
    @Environment(\.safeAreaInsets) private var safeAreaInsets
    let contentView: () -> ContentView
    
    func body(content: Content) -> some View {
        content
            .overlay {
                if isPresented {
                    ZStack(alignment: .bottom) {
                        Color.black.opacity(0.5).ignoresSafeArea(.all)
                            .onTapGesture {
                                dismissSheet()
                            }
                        
                        VStack {
                            contentView()
                                .padding(.horizontal, 16)
                                .padding(.top, 38)
                                .padding(.bottom, 30)
                                .background(GeometryReader { proxy in
                                    Color.clear
                                        .onAppear {
                                            DispatchQueue.main.async {
                                                dynamicHeight = proxy.size.height
                                                offset = dynamicHeight
                                            }
                                        }
                                })
                        }
                        .frame(maxWidth: .infinity, maxHeight: maxHeight)
                        .background(.white)
                        .cornerRadius(24)
                        .offset(y: max(safeAreaInsets.bottom, offset + translation))                        
                        .gesture(
                            DragGesture()
                                .onChanged { value in
                                    lastDragHeight = value.translation.height
                                }
                                .updating($translation) { value, state, _ in
                                    if value.translation.height > 0 {
                                        state = value.translation.height
                                    }
                                }
                                .onEnded { value in
                                    let dragHeight = value.translation.height
                                    let velocity = value.predictedEndTranslation.height
                                    let dragDirection = dragHeight - lastDragHeight > 0
                                    
                                    if dragDirection, (dragHeight > 50 || velocity > 500) {
                                        // offset을 드래그 위치로 업데이트
                                            offset = dragHeight
                                            dismissSheet()
                                    } else {
                                        withAnimation(.spring(response: 0.4, dampingFraction: 0.7)) {
                                            offset = 0
                                        }
                                    }
                                }
                        )
                    }
                    .onAppear {
                        DispatchQueue.main.async {
                            withAnimation(.spring(response: 0.4, dampingFraction: 0.725)) {
                                offset = 0
                            }
                        }
                    }
                }
            }
    }
    
    private func dismissSheet() {
        withAnimation(.spring(response: 0.4, dampingFraction: 0.8)) {
            offset = dynamicHeight + safeAreaInsets.bottom
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            isPresented = false
        }
    }
}

extension View {
    func bottomSheet<Content>(_ isPresented: Binding<Bool>,
                              maxHeight: CGFloat? = nil,
                              content: @escaping () -> Content) -> some View where Content: View {
        modifier(DDBottomSheet(isPresented: isPresented,
                               maxHeight: maxHeight,
                               contentView: content))
    }
}

