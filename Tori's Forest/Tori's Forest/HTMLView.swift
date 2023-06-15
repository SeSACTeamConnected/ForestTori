//
//  HTMLView.swift
//  Tori's Forest
//
//  Created by hyebin on 2023/06/16.
//

import SwiftUI
import WebKit

struct HTMLView: UIViewRepresentable {
    let htmlString: String
    
    func makeUIView(context: Context) -> WKWebView {
        return WKWebView()
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        uiView.loadHTMLString(htmlString, baseURL: Bundle.main.resourceURL)
    }
}
