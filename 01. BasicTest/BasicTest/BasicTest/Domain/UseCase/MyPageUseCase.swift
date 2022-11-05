//
//  MyPageUseCase.swift
//  PresentationTests
//
//  Created by Junho Lee on 2022/10/09.
//  Copyright © 2022 RecorDream. All rights reserved.
//

import RxSwift
import RxRelay

public protocol MyPageUseCase {
    // 회원 정보를 Token으로 요청하기 때문에 파라미터 없음
    func fetchMyPageData()
    func validateUsernameEdit()
    func restartUsernameEdit()
    func startUsernameEdit()
    func editUsername(username: String)
    func userLogout()
    func userWithdrawl()
    
    var myPageFetched: PublishSubject<MyPageEntity?> { get set }
    var logoutSuccess: PublishSubject<Void> { get set }
    var withdrawlSuccess: PublishSubject<Void> { get set }
    var usernameEditStatus: BehaviorRelay<Bool> { get set }
    var shouldShowAlert: PublishRelay<Void> { get set }
}

public class DefaultMyPageUseCase {
    
    private let repository: MyPageRepository
    private let disposeBag = DisposeBag()
    
    public var myPageFetched = PublishSubject<MyPageEntity?>()
    public var usernameEditStatus = BehaviorRelay<Bool>(value: false)
    public var shouldShowAlert = PublishRelay<Void>()
    public var logoutSuccess = PublishSubject<Void>()
    public var withdrawlSuccess = PublishSubject<Void>()
    
    public init(repository: MyPageRepository) {
        self.repository = repository
    }
}

extension DefaultMyPageUseCase: MyPageUseCase {
    
    public func fetchMyPageData() {
        self.repository.fetchUserInformation()
            .subscribe(onNext: { entity in
                self.myPageFetched.onNext(entity)
            }).disposed(by: self.disposeBag)
    }
    
    // TODO: - repostiory에 요청하고 성공하면 stopUsername 호출
    public func editUsername(username: String) {
        stopUsernameEdit()
    }
    
    public func validateUsernameEdit() {
        let isAlreadyEditing = usernameEditStatus.value
        
        guard !isAlreadyEditing else { return }
        usernameEditStatus.accept(true)
    }
    
    private func stopUsernameEdit() {
        usernameEditStatus.accept(false)
    }
    
    public func startUsernameEdit() {
        usernameEditStatus.accept(true)
    }
    
    public func restartUsernameEdit() {
        usernameEditStatus.accept(true)
        shouldShowAlert.accept(())
    }
    
    public func userLogout() {
        self.repository.userLogout()
            .filter { $0 }
            .subscribe(onNext: { _ in
                self.logoutSuccess.onNext(())
            }).disposed(by: self.disposeBag)
    }
    
    public func userWithdrawl() {
        self.repository.userWithdrawl()
            .filter { $0 }
            .subscribe(onNext: { _ in
                self.withdrawlSuccess.onNext(())
            }).disposed(by: self.disposeBag)
    }
}
