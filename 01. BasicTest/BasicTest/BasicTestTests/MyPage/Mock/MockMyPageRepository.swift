//
//  MockRepository.swift
//  BasicTestTests
//
//  Created by Junho Lee on 2022/11/05.
//

import Foundation

import RxSwift

@testable import BasicTest

final class MockMyPageRepository: MyPageRepository {
    func fetchUserInformation() -> Observable<MyPageEntity> {
        return Observable.just(Self.sampleFetchedData)
    }
    
    func userLogout() -> Observable<Bool> {
        return Observable.just(true)
    }
    
    func userWithdrawl() -> Observable<Bool> {
        return Observable.just(true)
    }
}

extension MockMyPageRepository {
    static let sampleFetchedData = MyPageEntity.init(userName: "샘플",
                                                     email: "이메일@naver.com",
                                                     pushOnOff: true,
                                                     pushTime: nil)
    
    static let sampleFetchedWrongData = MyPageEntity.init(userName: "샘플",
                                                     email: "이메일@naver.co",
                                                     pushOnOff: true,
                                                     pushTime: nil)
}
