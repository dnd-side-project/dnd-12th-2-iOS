//
//  DDRoundTextField.swift
//  dnd-12th-2-iOS
//
//  Created by 권석기 on 2/11/25.
//

import SwiftUI

struct DDRoundTextFiled: View {
    @Binding var text: String
    var body: some View {
        ZStack {
            Rectangle()
                .frame(maxWidth: .infinity, minHeight: 48)
                .foregroundColor(Color.gray50)
                .cornerRadius(12)
            
            HStack {
                TextField("dd", text: $text, prompt: Text("ex) OO에서 OO하기"))
                    .font(.pretendard(size: 16, weight: .medium))
                    .foregroundStyle(Color.gray300)
                
                Text("0/50")
                    .font(.pretendard(size: 12, weight: .regular))
                    .foregroundStyle(Color.gray500)
            }
            .padding(.horizontal, 8)
        }
    }
}

#Preview {
    DDRoundTextFiled(text: .constant(""))
}

