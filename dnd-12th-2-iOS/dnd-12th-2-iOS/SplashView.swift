//
//  SplashView.swift
//  dnd-12th-2-iOS
//
//  Created by Allie on 2/9/25.
//

import SwiftUI

struct SplashView: View {
    var body: some View {
        VStack {
            Spacer()
                .frame(height: 298)
            Image("iconApp")
                .resizable()
                .frame(width: 152, height: 152)
            Spacer()
        }
        .frame(maxHeight: .infinity)
        .ignoresSafeArea(.all)
    }
}

#Preview {
    SplashView()
}
