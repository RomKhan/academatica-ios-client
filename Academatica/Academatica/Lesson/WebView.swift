import SwiftUI
import Combine
import WebKit
import UIKit

enum WebViewNavigationAction {
    case backward, forward, reload
}

enum URLType {
    case local, `public`
}

struct Webview: UIViewRepresentable {
    var type: URLType
    var url: String?
    @Binding var dynamicHeight: CGFloat
    var webview: WKWebView = WKWebView()

    class Coordinator: NSObject, WKNavigationDelegate {
        var parent: Webview

        init(_ parent: Webview) {
            self.parent = parent
        }

        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
            webView.evaluateJavaScript("document.readyState", completionHandler: { (complete, error) in
                if complete != nil {
                    webView.evaluateJavaScript("document.documentElement.scrollHeight", completionHandler: { (height, error) in
                        if height != nil {
                            DispatchQueue.main.async {
                                self.parent.dynamicHeight = height as! CGFloat
                            }
                        }
                    })
                }
            })
        }
        
        func webView(_ webView: WKWebView, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
            DispatchQueue.main.async {
                guard let serverTrust = challenge.protectionSpace.serverTrust else {
                    completionHandler(.useCredential, nil)
                    return
                }
                
                let credential = URLCredential(trust: serverTrust)
                completionHandler(.useCredential, credential)
            }
        }
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    func makeUIView(context: Context) -> WKWebView  {
        webview.scrollView.bounces = false
        webview.navigationDelegate = context.coordinator
        webview.allowsBackForwardNavigationGestures = true
        webview.scrollView.isScrollEnabled = false
        return webview
    }

    func updateUIView(_ webView: WKWebView, context: Context) {
        if let urlValue = url  {
            if let requestUrl = URL(string: urlValue) {
                webView.load(URLRequest(url: requestUrl))
            }
        }
    }
}
