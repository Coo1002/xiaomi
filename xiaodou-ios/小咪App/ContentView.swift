import SwiftUI
import WebKit

/// 承载小咪 H5 的 WKWebView 容器
struct PetWebView: UIViewRepresentable {
    func makeCoordinator() -> Coordinator { Coordinator() }

    func makeUIView(context: Context) -> WKWebView {
        let config = WKWebViewConfiguration()
        // 接收 H5 通过 window.webkit.messageHandlers.petBridge 上报的状态
        config.userContentController.add(context.coordinator, name: "petBridge")
        if #available(iOS 16.4, *) {
            config.preferences.isElementFullscreenEnabled = true
        }
        let webView = WKWebView(frame: .zero, configuration: config)
        webView.isOpaque = false
        webView.backgroundColor = UIColor(red: 0.984, green: 0.965, blue: 0.933, alpha: 1)
        webView.scrollView.contentInsetAdjustmentBehavior = .never
        webView.allowsBackForwardNavigationGestures = false
        if let url = Bundle.main.url(forResource: "index", withExtension: "html", subdirectory: "web") {
            webView.loadFileURL(url, allowingReadAccessTo: url.deletingLastPathComponent())
        }
        return webView
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {}

    class Coordinator: NSObject, WKScriptMessageHandler {
        func userContentController(_ userContentController: WKUserContentController,
                                   didReceive message: WKScriptMessage) {
            guard message.name == "petBridge",
                  let json = message.body as? String,
                  let data = json.data(using: .utf8),
                  let dict = try? JSONSerialization.jsonObject(with: data) as? [String: Any]
            else { return }
            PetLiveBridge.shared.handle(payload: dict)
        }
    }
}
