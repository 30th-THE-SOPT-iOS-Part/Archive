//
//  LoginModel.swift
//  Seminar4
//
//  Created by taehy.k on 2022/05/07.
//

import Foundation

struct LoginResponse: Codable {
    let status: Int
    let success: Bool?
    let message: String
    let data: LoginData?
}

struct LoginData: Codable {
    let name: String
    let email: String
}
