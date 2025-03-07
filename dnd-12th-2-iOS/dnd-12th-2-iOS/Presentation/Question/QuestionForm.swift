//
//  QuestionView.swift
//  dnd-12th-2-iOS
//
//  Created by 권석기 on 3/1/25.
//

import SwiftUI
import ComposableArchitecture

struct QuestionForm: View {
    let store: StoreOf<Questionnaire>
    
    var body: some View {
        WithPerceptionTracking {
            VStack(spacing: 0) {
                Text(store.questions[store.currentStep].title)
                    .foregroundStyle(Color.gray900)
                    .headingStyle2()
                    .alignmentLeading()
                    .padding(.top, 16)
                
                Text(store.questions[store.currentStep].description)
                    .foregroundStyle(Color.gray600)
                    .bodyLargeMedium()
                    .alignmentLeading()
                    .padding(.top, 12)
                
                VStack(spacing: 12) {
                    ForEach(Array(store.questions[store.currentStep].answers.enumerated()), id: \.offset) { (index, answer) in
                        DDRow(title: answer.content, isSelected: answer.isSelected, action: {
                            store.send(.answerTapped(answerId: index))
                        })
                    }
                }
                .padding(.top, 50)
                
                Spacer()
                
                DDButton(action: {store.send(.incrementStep)})
            }
            .background(Color.white)
            .id(store.currentStep)
            .animation(.default, value: store.currentStep)
            .transition(store.currentStep >= store.prevStep ?   AnyTransition.asymmetric(
                insertion: .move(edge: .trailing),
                removal: .move(edge: .leading)) :   AnyTransition.asymmetric(
                    insertion: .move(edge: .leading),
                    removal: .move(edge: .trailing)))
        }
    }
}

//#Preview {
//    QuestionView()
//}
