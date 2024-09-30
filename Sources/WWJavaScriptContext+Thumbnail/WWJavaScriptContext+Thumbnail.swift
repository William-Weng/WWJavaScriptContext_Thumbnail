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
    
    /// 取得該網頁的縮圖網址
    /// - Parameters:
    ///   - urlString: 網址
    ///   - encoding: 文字編碼
    ///   - result: (Result<JSValue?, Error>) -> Void
    func thumbnailURL(urlString: String, using encoding: String.Encoding = .utf8, result: @escaping (Result<JSValue?, Error>) -> Void) {
        
        parseURL(urlString, using: encoding) { _result in
            
            switch _result {
            case .failure(let error): result(.failure(error))
            case .success(let html): result(.success(self.parseHTML(html)))
            }
        }
    }
    
    /// 取得該網頁的縮圖資料
    /// - Parameters:
    ///   - urlString: 網址
    ///   - encoding: 文字編碼
    ///   - characterSet: URL編碼處理 => .urlQueryAllowed
    ///   - result: (Result<Data?, Error>) -> Void
    func thumbnailData(urlString: String, using encoding: String.Encoding = .utf8, characterSet: CharacterSet? = nil, result: @escaping (Result<Data?, Error>) -> Void) {
        
        thumbnailURL(urlString: urlString, using: encoding) { _result in
            
            switch _result {
            case .failure(let error): result(.failure(error))
            case .success(let jsValue):
                
                var thumbnailUrlString = jsValue?.toString()
                
                if let characterSet = characterSet {
                    thumbnailUrlString = thumbnailUrlString?._encodingURL(characterSet: characterSet)
                }
                
                guard var thumbnailUrlString = thumbnailUrlString else { result(.failure(Constant.MyError.encoding)); return }
                
                WWNetworking.shared.request(urlString: thumbnailUrlString) { _result_ in
                    
                    switch _result_ {
                    case .failure(let error): result(.failure(error))
                    case .success(let info): result(.success(info.data))
                    }
                }
            }
        }
    }
    
    /// 取得該網頁的縮圖
    /// - Parameters:
    ///   - urlString: 網址
    ///   - encoding: 文字編碼
    ///   - characterSet: URL編碼處理 => .urlQueryAllowed
    ///   - result: (Result<Data?, Error>) -> Void
    func thumbnail(urlString: String, using encoding: String.Encoding = .utf8, characterSet: CharacterSet? = nil, result: @escaping (Result<UIImage?, Error>) -> Void) {
        
        thumbnailData(urlString: urlString, using: encoding, characterSet: characterSet) { _result in
            
            switch _result {
            case .failure(let error): result(.failure(error))
            case .success(let data):
                guard let data = data else { result(.failure(Constant.MyError.noData)); return }
                result(.success(UIImage(data: data)))
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
