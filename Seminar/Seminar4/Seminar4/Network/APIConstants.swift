//
//  APIConstants.swift
//  Seminar4
//
//  Created by taehy.k on 2022/05/07.
//

import Foundation

/*
 API Constants
 
 - 주소를 모아놓은 구조체
 - 이름은 형식상 API를 모아 놓았다는 느낌으로 APIConstants라고 지음
 */

struct APIConstants {
    // MARK: - Base URL
    static let baseURL = "http://13.124.62.236"
    
    // MARK: - Feature URL
    // loginURL = "http://13.124.62.236/auth/signin"
    static let loginURL = baseURL + "/auth/signin"
    
    // signUpURL = "http://13.124.62.236/auth/signin"
    static let signUpURL = baseURL + "/auth/signup"
}
