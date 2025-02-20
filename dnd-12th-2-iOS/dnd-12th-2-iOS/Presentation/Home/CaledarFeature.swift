//
//  CaledarFeature.swift
//  dnd-12th-2-iOS
//
//  Created by 권석기 on 2/20/25.
//


import ComposableArchitecture

@Reducer
struct CalendarFeature {
    @ObservableState
    struct State {
        var yeanAndMonth = "2025년 1월"
        var days: [[Day]] = [
            [Day(day: "", dayNumber: "", successCount: 0, totalCount: 0),
             Day(day: "", dayNumber: "", successCount: 0, totalCount: 0),
             Day(day: "", dayNumber: "", successCount: 0, totalCount: 0),
             Day(day: "", dayNumber: "", successCount: 0, totalCount: 0),
             Day(day: "", dayNumber: "", successCount: 0, totalCount: 0),
             Day(day: "", dayNumber: "", successCount: 0, totalCount: 0),
             Day(day: "", dayNumber: "", successCount: 0, totalCount: 0),
             Day(day: "", dayNumber: "", successCount: 0, totalCount: 0),
            ],
            
            [Day(day: "", dayNumber: "", successCount: 0, totalCount: 0),
             Day(day: "", dayNumber: "", successCount: 0, totalCount: 0),
             Day(day: "", dayNumber: "", successCount: 0, totalCount: 0),
             Day(day: "", dayNumber: "", successCount: 0, totalCount: 0),
             Day(day: "", dayNumber: "", successCount: 0, totalCount: 0),
             Day(day: "", dayNumber: "", successCount: 0, totalCount: 0),
             Day(day: "", dayNumber: "", successCount: 0, totalCount: 0),
             Day(day: "", dayNumber: "", successCount: 0, totalCount: 0),
            ],
            
            [Day(day: "", dayNumber: "", successCount: 0, totalCount: 0),
             Day(day: "", dayNumber: "", successCount: 0, totalCount: 0),
             Day(day: "", dayNumber: "", successCount: 0, totalCount: 0),
             Day(day: "", dayNumber: "", successCount: 0, totalCount: 0),
             Day(day: "", dayNumber: "", successCount: 0, totalCount: 0),
             Day(day: "", dayNumber: "", successCount: 0, totalCount: 0),
             Day(day: "", dayNumber: "", successCount: 0, totalCount: 0),
             Day(day: "", dayNumber: "", successCount: 0, totalCount: 0),
            ],
            
        ]
         var index = 0
        
        let dummyDays = [Day(day: "", dayNumber: "", successCount: 0, totalCount: 0),
                         Day(day: "", dayNumber: "", successCount: 0, totalCount: 0),
                         Day(day: "", dayNumber: "", successCount: 0, totalCount: 0),
                         Day(day: "", dayNumber: "", successCount: 0, totalCount: 0),
                         Day(day: "", dayNumber: "", successCount: 0, totalCount: 0),
                         Day(day: "", dayNumber: "", successCount: 0, totalCount: 0),
                         Day(day: "", dayNumber: "", successCount: 0, totalCount: 0),
                         Day(day: "", dayNumber: "", successCount: 0, totalCount: 0),
                        ]
        
        init() {
            self.index = 1
            self.days.append(dummyDays)
        }
    }
    
    enum Action: BindableAction {
        case binding(BindingAction<State>)
        case setIndex(Int)
    }
    
    var body: some Reducer<State, Action> {
        BindingReducer()
        Reduce { state, action in
            switch action {
            case .binding(\.index):
                let lastIndex = state.days.count - 1
                
                if state.index == 0 {
                       state.days.insert(state.dummyDays, at: 0)
                       state.index += 1
                   }
                   else if state.index == lastIndex {
                       state.days.append(state.dummyDays)
                   }
                return .none
            case let .setIndex(index):
                return .none
            default:
                return .none
            }
        }
        ._printChanges()
    }
}
