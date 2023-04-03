//
//  RDNaviBar.swift
//  RD-DSKit
//
//  Created by Junho Lee on 2022/10/06.
//  Copyright © 2022 BasicTest. All rights reserved.
//

import UIKit

import RxSwift
import RxCocoa
import SnapKit

public class RDNaviBar: UIView {
    
    // MARK: - Properties
    
    public var rightButtonTapped: ControlEvent<Void> {
        return rightButton.rx.tap
    }
    
    // MARK: - UI Components
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 16.adjusted)
        
        return label
    }()
    
    private let rightButton: UIButton = {
        let bt = UIButton()
        bt.setImage(UIImage(), for: .normal)
        bt.tintColor = .white
        return bt
    }()
    
    private let bottomLine: UIView = {
        let view = UIView()
        view.backgroundColor = .white.withAlphaComponent(0.1)
        return view
    }()
    
    // MARK: - Life Cycles
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUI()
        setLayout()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)

        setUI()
        setLayout()
    }
    
    // MARK: - Methods
    
    private func setUI() {
        self.backgroundColor = .black
    }
    
    private func setLayout() {
        self.addSubviews(rightButton, titleLabel, bottomLine)
        
        rightButton.snp.makeConstraints { make in
            make.centerY.equalTo(titleLabel)
            make.leading.equalToSuperview().inset(16)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        bottomLine.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.height.equalTo(1)
        }
    }
    
    @discardableResult
    public func title(_ title: String) -> Self {
        titleLabel.text = title
        
        return self
    }
    
    @discardableResult
    public func titleColor(_ color: UIColor) -> Self {
        self.titleLabel.textColor = color
        
        return self
    }

    @discardableResult
    public func font(_ font: UIFont) -> Self {
        self.titleLabel.font = font
        
        return self
    }
    
    @discardableResult
    public func backgroundColor(_ color: UIColor) -> Self {
        self.backgroundColor = color
        
        return self
    }
    
    @discardableResult
    public func rightButtonImage(_ image: UIImage) -> Self {
        self.rightButton.setImage(image, for: .normal)
        
        return self
    }
}
