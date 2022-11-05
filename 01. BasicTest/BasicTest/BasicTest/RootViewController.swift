//
//  RootViewController.swift
//  BasicTest
//
//  Created by Junho Lee on 2022/11/05.
//

import UIKit

import RxSwift
import SnapKit

class RootViewCowntroller: UIViewController {
    
    let disposeBag = DisposeBag()
    
    lazy var pushButton: UIButton = {
        let bt = UIButton()
        bt.setTitle("마이페이지 전환", for: .normal)
        bt.setTitleColor(.black, for: .normal)
        bt.addAction(UIAction(handler: { [weak self] _ in
            guard let self = self else { return }
                self.navigationController?.pushViewController(self.makeMyPageViewController(), animated: true)
        }), for: .touchUpInside)
        return bt
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setLayout()
    }
    
    func setLayout() {
        self.view.addSubview(pushButton)
        pushButton.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
    func makeMyPageViewController() -> MyPageVC {
        let repository = DefaultMyPageRepository()
        let useCase = DefaultMyPageUseCase(repository: repository)
        let vc = MyPageVC()
        vc.viewModel = MyPageViewModel(useCase: useCase)
        
        vc.viewModel.logoutCompleted
            .bind { _ in
                vc.navigationController?.popViewController(animated: true)
            }.disposed(by: self.disposeBag)
        
        vc.viewModel.withdrawlCompleted
            .bind { _ in
                vc.navigationController?.popViewController(animated: true)
            }.disposed(by: self.disposeBag)
        
        vc.naviBar.rightButtonTapped
            .bind { _ in
                vc.navigationController?.popViewController(animated: true)
            }.disposed(by: self.disposeBag)
                       
        return vc
    }
}
