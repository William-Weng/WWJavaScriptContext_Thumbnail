//
//  ViewController.swift
//  Example
//
//  Created by William.Weng on 2024/9/30.
//

import UIKit
import JavaScriptCore
import WWPrint
import WWJavaScriptContext
import WWJavaScriptContext_Thumbnail

// MARK: - ViewController
final class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let urlString = "https://www.explainthis.io/zh-hant/swe/script-link-in-html"
        
        WWJavaScriptContext.Thumbnail.shared.thumbnailURL(urlString: urlString) { result in
            
            switch result {
            case .failure(let error): wwPrint(error)
            case .success(let jsValue): wwPrint(jsValue)
            }
        }
    }
}
