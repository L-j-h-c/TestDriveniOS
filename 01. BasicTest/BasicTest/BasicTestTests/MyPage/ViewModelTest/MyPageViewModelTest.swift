//
//  MyPageViewModelTest.swift
//  BasicTestTests
//
//  Created by Junho Lee on 2022/11/05.
//

import XCTest

@testable import BasicTest

final class MyPageViewModelTest: XCTestCase {

    private var myPageUseCase: MyPageUseCase!
    private var myPageRepository: MyPageRepository!
    private var myPageViewModel: MyPageViewModel!
    
    override func setUp() {
        self.myPageRepository = MockMyPageRepository()
        self.myPageUseCase = DefaultMyPageUseCase(repository: self.myPageRepository)
        self.myPageViewModel = MyPageViewModel(useCase: self.myPageUseCase)
    }
}
