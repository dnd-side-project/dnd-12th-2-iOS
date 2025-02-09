//
//  SuccessView.swift
//  dnd-12th-2-iOS
//
//  Created by Allie on 2/7/25.
//

import SwiftUI

struct SuccessView: View {
    var body: some View {
        VStack {
            HStack {
                Text("축하해요!\n목표 달성을 성공했어요.")
                    .font(.pretendard(size: 22, weight: .bold))
                    .foregroundStyle(.gray900)
                    .multilineTextAlignment(.leading)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.top, 84)
                    .padding(.leading, 20)
                Spacer()
            }
            
            Spacer()
            
            Image("iconParty")
                .resizable()
                .scaledToFit()
                .frame(width: 288, height: 288)
                .padding(.bottom, 95)
            
            DDButton(title: "새로운 목표 설정하기", backgroundColor: .purple500, textColor: .white, width: 335, height: 60) {
                print("새로운 목표 설정하기")
            }
            .padding(.bottom, 12)
            Button(action: {
                print("다음에 할래요")
            }) {
                Text("다음에 할래요")
                    .underline()
                    .font(.pretendard(size: 14, weight: .semibold))
                    .foregroundStyle(.gray700)
            }
        }
        .frame(maxHeight: .infinity)
    }
}

#Preview {
    SuccessView()
}
