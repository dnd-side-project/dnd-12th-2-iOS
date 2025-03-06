//
//  PlanListVIew.swift
//  dnd-12th-2-iOS
//
//  Created by 권석기 on 3/2/25.
//

import SwiftUI
import ComposableArchitecture
import UIKit

struct PlanListVIew: View {
    let store: StoreOf<FetchPlan>
    let list: [[Int]] = [[1, 2, 3], [4, 5, 6], [7, 8], [9, 10, 11, 12]]
    @State private var isScrolling = false
    
    var body: some View {
        WithPerceptionTracking {
            ScrollViewReader { proxy in
                WithPerceptionTracking {                    
                    ScrollViewWrapper(isScrolling: $isScrolling) {
                            LazyVStack(spacing: 24) {
                                ForEach(0...3, id: \.self) { index in
                                    Text("2월 22일")
                                        .bodyMediumMedium()
                                        .alignmentLeading()
                                        .foregroundStyle(Color.gray500)
                                    ForEach(list[index], id: \.self) { _ in
                                        LazyVStack(spacing: 16) {
                                            DDResultRow(action: {})
                                        }
                                    }
                                }
                            }
                            .padding(.top, 11)
                    }
                }
            }
            .overlay(alignment: .top) {
                Divider()
                    .frame(width: UIScreen.screenWidth)
            }
            .overlay(alignment: .bottomTrailing, content: {
                DDFloatingButton(isExpanded: !isScrolling) {
                    
                }
                .offset(y: -10)
                .animation(.easeInOut(duration: 0.2), value: isScrolling)
            })
        }
    }
}

struct ScrollViewWrapper<Content: View>: UIViewRepresentable {
    @Binding var isScrolling: Bool
    let content: Content

    init(isScrolling: Binding<Bool>, @ViewBuilder content: () -> Content) {
        self._isScrolling = isScrolling
        self.content = content()
    }

    func makeCoordinator() -> Coordinator {
        return Coordinator(isScrolling: $isScrolling)
    }

    func makeUIView(context: Context) -> UIScrollView {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        let hostingController = UIHostingController(rootView: content)
        hostingController.view.translatesAutoresizingMaskIntoConstraints = false

        scrollView.addSubview(hostingController.view)
        scrollView.delegate = context.coordinator
        
        NSLayoutConstraint.activate([
            hostingController.view.topAnchor.constraint(equalTo: scrollView.topAnchor),
            hostingController.view.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            hostingController.view.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            hostingController.view.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            hostingController.view.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
                
        scrollView.contentSize = CGSize(width: scrollView.frame.width, height: hostingController.view.frame.height)
        
        return scrollView
    }

    func updateUIView(_ uiView: UIScrollView, context: Context) {
        // 내용이 업데이트 될 때마다 contentSize를 다시 설정
        uiView.contentSize = CGSize(width: uiView.frame.width, height: uiView.subviews.first?.frame.height ?? 0)
    }

    class Coordinator: NSObject, UIScrollViewDelegate {
        @Binding var isScrolling: Bool

        init(isScrolling: Binding<Bool>) {
            self._isScrolling = isScrolling
        }

        func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
            DispatchQueue.main.async {
                self.isScrolling = true
            }
        }

        func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
            DispatchQueue.main.async {
                self.isScrolling = false
            }
        }

        func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
            if !decelerate {
                DispatchQueue.main.async {
                    self.isScrolling = false
                }
            }
        }
    }
}
