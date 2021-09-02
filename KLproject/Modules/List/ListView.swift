//
//  ListView.swift
//  KLproject
//
//  Created by KL on 02/09/2021.
//

import UIKit

final class ListView: UIView {
    
    // MARK: - UI Components -
    
    // MARK: - Lifecycle -
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
        defineLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup -
    
    private func setup() {
        backgroundColor = .red
    }
    
    // MARK: - Layout -
    
    private func defineLayout() {
    }
}
