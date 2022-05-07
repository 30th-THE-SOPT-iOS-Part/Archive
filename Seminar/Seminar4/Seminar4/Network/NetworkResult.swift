//
//  NetworkResult.swift
//  Seminar4
//
//  Created by taehy.k on 2022/05/07.
//

/*
 서버 통신의 결과를 핸들링하기 위한 열거형
 
 - 서버 통신의 응답으로는 정말 다양한 결과들이 넘어옵니다.
 - 단순히 성공 또는 실패로만 구분되지 않고,
 - 요청은 성공했으나 서버 내부적인 문제로 값이 넘어오지 않거나,
 - 요청을 잘못된 경로나 방식으로 해서 응답을 못 받을수도 있죠.
 */

enum NetworkResult<T> {
    case success(T)         // 서버 통신 성공
    case requestErr(T)      // 요청 에러가 발생
    case pathErr            // 경로 에러
    case serverErr          // 서버의 내부 에러
    case networkFail        // 네트워크 연결 실패
}
