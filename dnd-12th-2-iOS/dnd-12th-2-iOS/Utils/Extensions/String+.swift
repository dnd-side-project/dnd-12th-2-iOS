//
//  String+.swift
//  dnd-12th-2-iOS
//
//  Created by 권석기 on 2/12/25.
//

extension String {
    func splitCharacter() -> String {
        return self.split(separator: "").joined(separator: "\u{200B}")
    }
}
