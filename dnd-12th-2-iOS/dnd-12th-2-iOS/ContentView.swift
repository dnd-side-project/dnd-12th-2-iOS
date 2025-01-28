//
//  ContentView.swift
//  dnd-12th-2-iOS
//
//  Created by Allie on 1/22/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
                .font(.system(size: 20))
            Text("Hello, world!")
                .font(.pretendard(size: 20, weight: .regular))
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
