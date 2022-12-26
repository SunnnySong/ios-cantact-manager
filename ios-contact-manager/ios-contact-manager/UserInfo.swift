//
//  UserInfo.swift
//  ios-contact-manager
//
//  Created by sei_dev on 12/22/22.
//

import Foundation

enum UserInfoParams {
    case name, phone
    
    var regex: String {
        switch self {
        case .name:
            return "^[A-Za-z ]+$"
        case .phone:
            return "^[0-9]{2,3}-[0-9]{3,4}-[0-9]{4}$"
        }
    }
    
    var error: IOError {
        switch self {
        case .name:
            return IOError.invalidName
        case .phone:
            return IOError.invalidphone
        }
    }
}

struct UserInfo {
    let name: String
    let age: Int
    let phone: String
    
    init(input: InfoInput) throws {
        guard let age = Int(input.age),
              (1...999).contains(age) else {
            throw IOError.invalidAge
        }
        self.age = age
        
        do {
            let regexName = try input.name.getInfoAfter(type: .name)
            self.name = regexName.components(separatedBy: " ").joined()
            self.phone = try input.phone.getInfoAfter(type: .phone)
        } catch {
            throw error
        }
    }
}

extension UserInfo: CustomStringConvertible {
    var description: String {
        return "\(self.age)세 \(self.name)(\(self.phone))"
    }
}
