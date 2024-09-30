//
//  WWJavaScriptContext+Thumbnail.swift
//  WWJavaScriptContext+Thumbnail
//
//  Created by William.Weng on 2024/9/30.
//

import UIKit
import JavaScriptCore
import WWNetworking
import WWJavaScriptContext

// MARK: - WWJavaScriptContext.Thumbnail
extension WWJavaScriptContext {
    
    open class Thumbnail: NSObject {
        
        public static let shared = Thumbnail()
        
        var context: WWJavaScriptContext?
        
        private override init() {
            super.init()
            self.context = self.build()
        }
    }
}

// MARK: - 公開函數
public extension WWJavaScriptContext.Thumbnail {
    
    /// 解析該網頁的縮圖網址
    /// - Parameters:
    ///   - urlString: 網址
    ///   - encoding: 文字編碼
    ///   - result: (Result<JSValue?, Error>) -> Void
    func parse(url urlString: String, using encoding: String.Encoding = .utf8, result: @escaping (Result<JSValue?, Error>) -> Void) {
        
        parseURL(urlString, using: encoding) { _result in
            
            switch _result {
            case .failure(let error): result(.failure(error))
            case .success(let html): result(.success(self.parseHTML(html)))
            }
        }
    }
}

// MARK: - 小工具
private extension WWJavaScriptContext.Thumbnail {
    
    /// 建立初始物件
    /// - Returns: WWJavaScriptContext?
    func build() -> WWJavaScriptContext? {
        return WWJavaScriptContext.build(script: "")
    }
    
    /// 讀取Script
    /// - Parameter filename: String
    /// - Returns: String?
    func readScript(with filename: String) -> String? {
        
        guard let sourcePath: String = Bundle.module.path(forResource: filename, ofType: nil),
              let script = try? String(contentsOfFile: sourcePath)
        else {
            return nil
        }
        
        return script
    }
    
    /// 將HTML中的縮圖URL解出來
    /// - Parameter html: HTML文字
    /// - Returns: JSValue?
    func parseHTML(_ html: String) -> JSValue? {
        
        guard let context = context,
              let script = readScript(with: "jsSource.js")
        else {
            return nil
        }
        
        let paramater = "let content = \(html)"
        let jsValue = context.evaluateScript(script)
        
        _ = context.evaluateScript(paramater)
        
        return context.callFunctionName("thumbnailUrl", arguments: [html])
    }
    
    /// 讀取該網頁的html文字
    /// - Parameters:
    ///   - urlString: URL網址
    ///   - encoding: 文字編碼
    ///   - result: (Result<String, Error>) -> Void
    func parseURL(_ urlString: String, using encoding: String.Encoding, result: @escaping (Result<String, Error>) -> Void) {
        
        _ = WWNetworking.shared.request(urlString: urlString) { _result in
            
            switch _result {
            case .failure(let error): result(.failure(error))
            case .success(let info):
                
                guard let data = info.data,
                      let html = data._string(using: encoding)
                else {
                    result(.failure(Constant.MyError.notString)); return
                }
                
                result(.success(html))
            }
        }
    }
}
