//
//  PriceChange.swift
//  KLproject
//
//  Created by KL on 02/09/2021.
//

import UIKit

enum PriceChange {
    case none, up, down
    
    var color: UIColor? {
        switch self {
        case .none: return nil
        case .up: return .green
        case .down: return .red
        }
    }
}
