//
//  MyPageViewModelTest.swift
//  BasicTestTests
//
//  Created by Junho Lee on 2022/11/05.
//

import XCTest

import Nimble
import Quick
import RxCocoa
import RxNimble
import RxSwift
import RxTest

@testable import BasicTest

final class MyPageViewModelTest: QuickSpec {
    override func spec() {
        var scheduler: TestScheduler!
        var disposeBag: DisposeBag!
        
        var testViewDidLoad: PublishSubject<Void>!
        var editButtonTapped: PublishSubject<Void>!
        var usernameEditOutput: PublishSubject<MyPageEditableView.EndEditOutput>!
        var usernameAlertDismissed: PublishSubject<Void>!
        var pushSwitchChanged: PublishSubject<Bool>!
        var pushTimePicked: PublishSubject<String>!
        var logoutButtonTapped: PublishSubject<Void>!
        var withdrawlButtonTapped: PublishSubject<Void>!
        
        beforeSuite {
            
        }
        
        afterSuite {
            
        }
        
        describe("MyPageVC가 로드되고") {
            var myPageUseCase: MyPageUseCase!
            var myPageViewModel: MyPageViewModel!
            var input: MyPageViewModel.Input!
            var output: MyPageViewModel.Output!
            
            beforeEach {
                scheduler = TestScheduler(initialClock: 0)
                disposeBag = DisposeBag()
                myPageUseCase = MockMyPageUseCase()
                myPageViewModel = MyPageViewModel(useCase: myPageUseCase)
                
                testViewDidLoad = PublishSubject<Void>()
                editButtonTapped = PublishSubject<Void>()
                usernameEditOutput = PublishSubject<MyPageEditableView.EndEditOutput>()
                usernameAlertDismissed = PublishSubject<Void>()
                pushSwitchChanged = PublishSubject<Bool>()
                pushTimePicked = PublishSubject<String>()
                logoutButtonTapped = PublishSubject<Void>()
                withdrawlButtonTapped = PublishSubject<Void>()
            }
            
            afterEach {
                scheduler = nil
                disposeBag = nil
                myPageUseCase = nil
                myPageViewModel = nil
                
                testViewDidLoad = nil
                editButtonTapped = nil
                usernameEditOutput = nil
                usernameAlertDismissed = nil
                pushSwitchChanged = nil
                pushTimePicked = nil
                logoutButtonTapped = nil
                withdrawlButtonTapped = nil
            }
            
            context("닉네임을 편집하려고 하는 상황") {
                
                beforeEach {
                    input = MyPageViewModel.Input(viewDidLoad: testViewDidLoad.asObservable(),
                                                  editButtonTapped: editButtonTapped.asObservable(),
                                                  usernameEditOutput: usernameEditOutput.asObservable(),
                                                  usernameAlertDismissed: usernameAlertDismissed.asObservable(),
                                                  pushSwitchChagned: pushSwitchChanged.asObservable(),
                                                  pushTimePicked: pushTimePicked.asObservable(),
                                                  logoutButtonTapped: logoutButtonTapped.asObservable(),
                                                  withdrawlButtonTapped: withdrawlButtonTapped.asObservable())
                    
                    output = myPageViewModel.transform(from: input, disposeBag: disposeBag)
                    
                    scheduler.createColdObservable([
                        .next(3, Void())
                    ])
                    .bind(to: testViewDidLoad)
                    .disposed(by: disposeBag)
                }
                
                it("먼저 데이터가 불러와진다.") {
                    DispatchQueue.main.async {
                        expect(output.myPageDataFetched)
                            .events(scheduler: scheduler, disposeBag: disposeBag)
                            .to(equal([
                                .next(0, nil),
                                .next(3, MockMyPageUseCase.sampleMyPageInformation),
                            ]))
                    }
                }
                
                context("editButton을 두 번 누르면") {
                    beforeEach {
                        scheduler.createColdObservable([
                            .next(15, Void()),
                            .next(30, Void())
                        ])
                        .bind(to: editButtonTapped)
                        .disposed(by: disposeBag)
                    }
                    
                    it("첫 번째에 닉네임 편집이 시작된다") {
                        DispatchQueue.main.async {
                            expect(output.startUsernameEdit)
                                .events(scheduler: scheduler, disposeBag: disposeBag)
                                .to(equal([
                                    .next(15, true)
                                ]))
                        }
                    }
                    
                    it("두 번은 눌러도 변화가 없다") {
                        DispatchQueue.main.async {
                            expect(output.startUsernameEdit)
                                .events(scheduler: scheduler, disposeBag: disposeBag)
                                .notTo(equal([
                                    .next(30, true)
                                ]))
                        }
                    }
                }
            }
        }
    }
}
