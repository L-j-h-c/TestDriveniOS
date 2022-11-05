//
//  MyPageUseCaseTest.swift
//  BasicTestTests
//
//  Created by Junho Lee on 2022/11/05.
//

import XCTest

import RxSwift
import RxTest

@testable import BasicTest

final class MyPageUseCaseTest: XCTestCase {
    
    private var scheduler: TestScheduler!
    private var disposeBag: DisposeBag!
    private var myPageUseCase: MyPageUseCase!
    private var myPageRepository: MyPageRepository!
    
    override func setUp() {
        self.scheduler = TestScheduler(initialClock: 0)
        self.disposeBag = DisposeBag()
        self.myPageRepository = MockMyPageRepository()
        self.myPageUseCase = DefaultMyPageUseCase(repository: self.myPageRepository)
    }
    
    override func tearDownWithError() throws {
        self.myPageUseCase = nil
        self.myPageRepository = nil
        self.disposeBag = nil
    }
    
    func test_check_fetching() {
        let fetchedDataOutput = scheduler.createObserver(MyPageEntity?.self)
        
        self.scheduler.createColdObservable([
            .next(10, ())
        ])
        .withUnretained(self)
        .subscribe(onNext: { strongSelf, _ in
            strongSelf.myPageUseCase.fetchMyPageData()
        })
        .disposed(by: self.disposeBag)
        
        self.myPageUseCase.myPageFetched
            .subscribe(fetchedDataOutput)
            .disposed(by: self.disposeBag)
        
        self.scheduler.start()
        
        XCTAssertEqual(fetchedDataOutput.events, [
            .next(10, MockMyPageRepository.sampleFetchedData)
        ])
    }
}
