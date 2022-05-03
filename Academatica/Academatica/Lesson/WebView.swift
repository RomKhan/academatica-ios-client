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

struct WebView: UIViewRepresentable {
    var type: URLType
    var url: String?
    @Binding var dynamicHeight: CGFloat

    class Coordinator: NSObject, WKNavigationDelegate {
        var parent: WebView

        init(_ parent: WebView) {
            self.parent = parent
        }

        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
//            webView.evaluateJavaScript("document.readyState", completionHandler: { (complete, error) in
//                if complete != nil {
//                    webView.evaluateJavaScript("document.documentElement.scrollHeight", completionHandler: { (height, error) in
//                        if height != nil {
//                            DispatchQueue.main.async {
//                                self.parent.dynamicHeight = height as! CGFloat + 15
//                            }
//                        }
//                    })
//                }
//            })
            DispatchQueue.main.async {
                self.parent.dynamicHeight = webView.scrollView.contentSize.height + 30
            }
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
        
        func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
            if (error as NSError).code == -999 {
                return
            }
            print(error)
        }
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    func makeUIView(context: Context) -> WKWebView  {
        let webview = WKWebView()
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
