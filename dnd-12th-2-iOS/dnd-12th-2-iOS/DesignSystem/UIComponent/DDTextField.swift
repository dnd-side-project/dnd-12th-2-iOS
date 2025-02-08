//
//  DDTextField.swift
//  dnd-12th-2-iOS
//
//  Created by 권석기 on 2/7/25.
//

import SwiftUI

struct DDTextField: View {
    @Binding var text: String
    
    var body: some View {
        VStack(spacing: 0) {
            TextField("", text: $text, prompt: Text("ex) OO에서 OO하기"))
                .font(.pretendard(size: 24, weight: .semibold))
                .frame(height: 54)
            
            Rectangle()
                .frame(height: 1)
                .foregroundStyle(Color.gray300)
            
            Spacer()
                .frame(height: 4)
            
            HStack {
                Text("\(text.count)/50")
                    .font(.pretendard(size: 12, weight: .regular))
                    .foregroundStyle(Color.gray700)
                
                Spacer()
            }
            
        }
    }
}

#Preview {
    DDTextField(text: .constant(""))
}
