//
//  Model.swift
//  Lab#1
//
//  Created by Андрей Бабкин on 27.10.2023.
//

import Foundation

enum TypeOfRegistrationCell: String {
    case login
    case email
    case password
    case repeatPassword
    
    var text: String {
        switch self {
        case .email:
            return "E-mail"
        case .login:
            return "Логин"
        case .password:
            return "Пароль"
        case .repeatPassword:
            return "Повторите пароль"
        }
    }
}

struct AuthorizationOptions {
    var typeOfRegistration: TypeOfRegistrationCell
    var text: String
}

