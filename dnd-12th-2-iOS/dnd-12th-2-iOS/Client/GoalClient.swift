//
//  GoalClient.swift
//  dnd-12th-2-iOS
//
//  Created by 권석기 on 2/19/25.
//

import Foundation
import ComposableArchitecture
import Moya

struct GoalClient {
    var fetchGoals: () async throws -> [Goal]
    var fetchPlans: (Int, String, Int) async throws -> [PlanGroup]
    var fetchStatistics: (Int, String) async throws -> [Day]
    static let provider = MoyaProvider<GoalAPI>(session: Session(interceptor: AuthIntercepter.shared))
}

extension GoalClient: DependencyKey {
    static let liveValue = Self(
        fetchGoals: {            
            do {
                let result: BaseResponse<[GoalResonseDto]> = try await provider.async.request(.fetchGoals)
                guard let data = result.data else {
                    throw APIError.parseError
                }
                return data.toEntity()
            } catch {
                throw error
            }
        },
        fetchPlans: { goalId, date, range in
            
            do {
                let result: BaseResponse<[PlanGroupResponseDto]> = try await provider.async.request(.fetchPlans(goalId, date, range))
                // yyyy-mm-dd 의 데이터가 리스트에 없다면 빈배열 반환
                guard let data = result.data else {
                    throw APIError.parseError
                }
             
                let selectedDate = date.toDate(timeFormat: "yyyy-MM-dd")
                
               let isNotSameDate = data.flatMap { $0.plans }.filter {
                     Calendar.current.isDate($0.startDate.toDate(), equalTo: selectedDate, toGranularity: .day) ||
                    Calendar.current.isDate($0.endDate.toDate(), equalTo: selectedDate, toGranularity: .day)
               }.isEmpty
                
                if isNotSameDate {
                    return []
                } else {
                    return data.toEntity()
                }
            } catch {                
                throw error
            }
        }, fetchStatistics: { goalId, date in
            do {
                let result: BaseResponse<[StatisticsResponseDto]> = try await provider.async.request(.fetchStatistics(goalId, date))
                guard let data = result.data else {
                    throw APIError.parseError
                }
                return data.toEntity()
            } catch {
                throw error
            }
        }
    )
}

extension DependencyValues {
    var goalClient: GoalClient {
        get { self[GoalClient.self] }
        set { self[GoalClient.self] = newValue }
    }
}

