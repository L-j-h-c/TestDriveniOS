//
//  MockMyPageUseCase.swift
//  BasicTestTests
//
//  Created by Junho Lee on 2022/11/06.
//

import Foundation

import RxRelay
import RxSwift

@testable import BasicTest

final class MockMyPageUseCase: MyPageUseCase {
    var myPageFetched = PublishSubject<MyPageEntity?>()
    
    var logoutSuccess = PublishSubject<Void>()
    
    var withdrawlSuccess = PublishSubject<Void>()
    
    var usernameEditStatus = BehaviorRelay<Bool>(value: false)
    
    var shouldShowAlert = PublishRelay<Void>()
    
    var updatePushSuccess = PublishSubject<String?>()
}

extension MockMyPageUseCase {
    
    func fetchMyPageData() {
        myPageFetched.onNext(MockMyPageUseCase.sampleMyPageInformation)
    }
    
    func validateUsernameEdit() {
        let isAlreadyEditing = usernameEditStatus.value
        
        guard !isAlreadyEditing else { return }
        usernameEditStatus.accept(true)
    }
    
    func restartUsernameEdit() {
        
    }
    
    func startUsernameEdit() {
        
    }
    
    func editUsername(username: String) {
        
    }
    
    func userLogout() {
        
    }
    
    func userWithdrawl() {
        
    }
    
    func disablePushNotice() {
        
    }
    
    func enablePushNotice(time: String) {
        
    }
}

extension MockMyPageUseCase {
    static let sampleMyPageInformation = MyPageEntity.init(userName: "샘플",
                                                           email: "이메일",
                                                           pushOnOff: true,
                                                           pushTime: nil)
}
