//
//  InitialGoalFeature.swift
//  dnd-12th-2-iOS
//
//  Created by Allie on 2/20/25.
//

import Foundation

import ComposableArchitecture

@Reducer
struct InitialGoalFeature: Reducer {
    @ObservableState
    struct State: Equatable {
        var goalTitle: String = ""
        var planTitle: String = ""
        var startDate: Date = Date()
        var endDate: Date = Date().addingTimeInterval(3600)
        var newGoalGuide: String = ""
        var newPlanGuide: String = ""
        var isStartTimeToggle: Bool = false
        var isEndTimeToggle: Bool = false
    }
    
    enum Action: BindableAction {
        case binding(BindingAction<State>)
        
        case setGoalTitle(String)
        case setPlanTitle(String)
        case setStartDate(Date)
        case setEndDate(Date)
        case toggleStartTime
        case toggleEndTime
        case getTips
        case tipsReceived(Guide)
        case goalCreated
        case completeButtonTapped
        case failure(Error)
    }
    
    @Dependency(\.planClient) var planClient
    
    var body: some ReducerOf<Self> {
        BindingReducer()
        Reduce { state, action in
            switch action {
            case let .setGoalTitle(title):
                state.goalTitle = title
                return .none
                
            case let .setPlanTitle(title):
                state.planTitle = title
                return .none
                
            case let .setStartDate(date):
                state.startDate = date
                return .none
                
            case let .setEndDate(date):
                state.endDate = date
                return .none
                
            case .toggleStartTime:
                state.isStartTimeToggle.toggle()
                state.isEndTimeToggle = false
                return .none
                
            case .toggleEndTime:
                state.isEndTimeToggle.toggle()
                state.isStartTimeToggle = false
                return .none
                
            case .getTips:
                return .run { send in
                    do {
                        let guide = try await planClient.getTips()
                        await send(.tipsReceived(guide))
                    } catch {
                        await send(.failure(error))
                    }
                }
                
            case let .tipsReceived(guide):
                state.newGoalGuide = guide.newGoalGuide
                state.newPlanGuide = guide.newPlanGuide
                return .none
                
            case .goalCreated:
                // 목표 생성 성공 후 처리
                return .none
                
            case .completeButtonTapped:
                let dateFormatter = ISO8601DateFormatter()
                dateFormatter.formatOptions = [.withFullDate, .withTime, .withColonSeparatorInTime]
                
                let initialGoal = InitialGoal(
                    goalTitle: state.goalTitle,
                    planTitle: state.planTitle,
                    startDate: dateFormatter.string(from: state.startDate),
                    endDate: dateFormatter.string(from: state.endDate)
                )
                return .run { send in
                    do {
                        try await planClient.createInitialGoal(initialGoal)
                        await send(.goalCreated)
                    } catch {
                        await send(.failure(error))
                    }
                }
                
            case .failure(let error):
                print("Error: \(error.localizedDescription)")
                return .none
            case .binding(_):
                return .none
            }
        }
    }
}
