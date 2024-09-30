//
//  Constant.swift
//  WWJavaScriptContext+Thumbnail
//
//  Created by William.Weng on 2024/9/30.
//

import Foundation

// MARK: - Constant
class Constant {
    
    enum MyError: Error, CustomDebugStringConvertible {
    
        var debugDescription: String { message() }
    
        case notString
        
        func message() -> String {
            
            switch self {
            case .notString: return "HTML文字編碼錯碼誤 / 沒資料"
            }
        }
    }
}
