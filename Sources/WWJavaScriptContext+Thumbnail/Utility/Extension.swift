//
//  Extension.swift
//  WWJavaScriptContext+Thumbnail
//
//  Created by William.Weng on 2024/9/30.
//

import UIKit

// MARK: - Data (function)
extension Data {
    
    /// Data => 字串
    /// - Parameter encoding: 字元編碼
    /// - Returns: String?
    func _string(using encoding: String.Encoding = .utf8) -> String? {
        return String(data: self, encoding: encoding)
    }
}
