//
//  DDDatePicker.swift
//  dnd-12th-2-iOS
//
//  Created by 권석기 on 2/7/25.
//

import SwiftUI
import UIKit

struct DDatePicker: View {
    var body: some View {
        HStack {
            // DDPicker를 합쳐서 DDatePicker를 만든다
            DDPicker(items: ["오전", "오후"])
                .frame(height: 56 * 3)
                .overlay(alignment: .top) {
                    Divider()
                        .offset(y: 56)
                    Divider()
                        .offset(y: 56 * 2)
                }
            
            Spacer()
                .frame(width: 45)
            
            DDPicker(items: Array(1...23).map {String($0)})
                .frame(height: 56 * 3)
                .overlay(alignment: .top) {
                    Divider()
                        .offset(y: 56)
                    Divider()
                        .offset(y: 56 * 2)
                }
                .frame(width: 44)
            Spacer()
                .frame(width: 24)
            
            DDPicker(items: Array(1...59).map {String($0)})
                .frame(height: 56 * 3)
                .overlay(alignment: .top) {
                    Divider()
                        .offset(y: 56)
                    Divider()
                        .offset(y: 56 * 2)
                }
                .frame(width: 44)
        }
        .frame(width: 307, height: 168)
        .overlay(alignment: .top) {
            Rectangle()
                .frame(height: 15)
                .foregroundStyle(Color.white)
                .offset(y: -10)
        }
        .overlay(alignment: .bottom) {
            Rectangle()
                .frame(height: 15)
                .foregroundStyle(Color.white)
                .offset(y: 10)
        }
    }
}

#Preview {
    DDatePicker()
}
