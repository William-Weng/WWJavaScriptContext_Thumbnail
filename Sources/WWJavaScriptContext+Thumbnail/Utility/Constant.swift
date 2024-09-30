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
        case notImage
        case noData
        case encoding
        
        /// 錯誤訊息
        /// - Returns: String
        func message() -> String {
            
            switch self {
            case .notString: return "HTML文字編碼錯碼誤 / 沒資料"
            case .notImage: return "不是圖形資料"
            case .noData: return "沒有資料"
            case .encoding: return "URL網址編碼錯誤"
            }
        }
    }
}
