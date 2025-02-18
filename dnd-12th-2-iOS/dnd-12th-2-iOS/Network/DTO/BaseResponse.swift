//
//  BaseResponse.swift
//  dnd-12th-2-iOS
//
//  Created by 권석기 on 2/16/25.
//

import Foundation

struct BaseResponse<T: Decodable>: Decodable {
    let code: String
    let message: String
    let data: T?
    
    enum CodingKeys: CodingKey {
        case code
        case message
        case data
    }
    
    init(from decoder: any Decoder) throws {
        let container: KeyedDecodingContainer<BaseResponse<T>.CodingKeys> = try decoder.container(keyedBy: BaseResponse<T>.CodingKeys.self)
        self.code = try container.decode(String.self, forKey: BaseResponse<T>.CodingKeys.code)
        self.message = try container.decode(String.self, forKey: BaseResponse<T>.CodingKeys.message)
        self.data = try container.decodeIfPresent(T.self, forKey: BaseResponse<T>.CodingKeys.data)
    }
}
