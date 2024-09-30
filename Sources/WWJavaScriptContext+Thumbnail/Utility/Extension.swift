//
//  Extension.swift
//  WWJavaScriptContext+Thumbnail
//
//  Created by William.Weng on 2024/9/30.
//

import UIKit

extension String {
    
    /// [URL編碼 (百分比)](https://medium.com/彼得潘的-swift-ios-app-開發教室/encode-a-url-with-網址encode特殊字元不轉換-a8614a140e45)
    /// - 是在哈囉 => %E6%98%AF%E5%9C%A8%E5%93%88%E5%9B%89
    /// - Parameter characterSet: 字元的判斷方式
    /// - Returns: String?
    func _encodingURL(characterSet: CharacterSet = .urlQueryAllowed) -> Self? { return addingPercentEncoding(withAllowedCharacters: characterSet) }
}

// MARK: - Data (function)
extension Data {
    
    /// Data => 字串
    /// - Parameter encoding: 字元編碼
    /// - Returns: String?
    func _string(using encoding: String.Encoding = .utf8) -> String? {
        return String(data: self, encoding: encoding)
    }
}
