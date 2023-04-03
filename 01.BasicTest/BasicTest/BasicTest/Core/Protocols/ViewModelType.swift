//
//  ViewModelType.swift
//
//  Created by Junho Lee on 2022/09/24.
//  Copyright © 2022 BasicTest. All rights reserved.
//

import Foundation

import RxSwift

public protocol ViewModelType {
    associatedtype Input
    associatedtype Output
    
    func transform(from input: Input, disposeBag: DisposeBag) -> Output
}
