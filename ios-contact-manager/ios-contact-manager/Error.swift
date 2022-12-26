//
//  Error.swift
//  ios-contact-manager
//
//  Created by 송선진 on 2022/12/22.
//

import Foundation

enum IOError: Error {
    case emptyInput
    case invalidName
    case invalidAge
    case invalidphone
    case inputFormatError
}

extension IOError: LocalizedError {
    public var errorDescription: String? {
        let description:String
        switch self {
        case .emptyInput:
            description = "아무것도 입력되지 않았습니다."
        case .invalidName:
            description = "입력한 이름 정보가 잘못되었습니다."
        case .invalidAge:
            description = "입력한 나이 정보가 잘못되었습니다."
        case .invalidphone:
            description = "입력한 연락처 정보가 잘못되었습니다."
        case .inputFormatError:
            description = "입력 형식이 잘못되었습니다."
        }
        return "\(description) \(StringLiteral.help)"
    }
}
