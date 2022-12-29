//
//  ContactManager.swift
//  ios-contact-manager
//
//  Created by 송선진 on 2022/12/22.
//

import Foundation

typealias InfoInput = (name: String, age: String, phone: String)

final class ContactManager {
    static let shared = ContactManager()
    private init() { }
    
    enum Option: String {
        case addContact = "1"
        case showAll = "2"
        case findContact = "3"
        case exit = "x"
    }
    
    private let inputPattern = #"^.+\b(?<sep>( \/ )|(\/))(\b[^\s]+\b)\k<sep>(\b[^\s]+)$"#
    private let phonebook = Phonebook(contacts: [:])
    
    func run() {
        do {
            IOManager.sendOutput(
                type: .menu,
                contents: StringLiteral.menu
            )
            let input = try IOManager.getInput()
            
            switch Option(rawValue: input) {
            case .addContact:
                try addContact()
            case .showAll:
                print("showAll")
            case .findContact:
                try findContact()
            case .exit:
                IOManager.sendOutput(
                    type: .infomation,
                    contents: StringLiteral.end
                )
                return
            default:
                IOManager.sendOutput(
                    type: .infomation,
                    contents: StringLiteral.wrongMenu
                )
            }
        } catch {
            IOManager.sendOutput(
                type: .error,
                contents: error.localizedDescription
            )
        }
        
        run()
    }
    
    private func parse(_ input: String) throws -> InfoInput {
        guard input ~= inputPattern else {
            throw IOError.invalidInputFormat
        }
        let splitedInput = input.components(separatedBy: "/").map {
            $0.trimmingCharacters(in: .whitespaces)
        }
        let infoInput = (name: splitedInput[0], age: splitedInput[1], phone: splitedInput[2])
        return infoInput
    }
}


// MARK: - addContact

extension ContactManager {
    private func addContact() throws {
        IOManager.sendOutput(
            type: .menu,
            contents: StringLiteral.addContact
        )
        let input = try IOManager.getInput()
        let parsedInfoInput = try parse(input)
        let userInfo = try UserInfo(input: parsedInfoInput)
        phonebook.add(contact: userInfo)
        
        IOManager.sendOutput(
            type: .infomation,
            contents: StringLiteral.infoPrint(of: userInfo)
        )
    }
}

// MARK: - findContract

extension ContactManager {
    private func findContact() throws {
        IOManager.sendOutput(
            type: .menu,
            contents: StringLiteral.findContract
        )
        let input = try IOManager.getInput()
        let userName = try input.matches(infoType: .name)
        let result = phonebook.getContact(of: userName) ?? StringLiteral.notFound(name: userName)
        IOManager.sendOutput(
            type: .infomation,
            contents: result
        )
    }
}

