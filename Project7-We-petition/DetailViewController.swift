//
//  DetailViewController.swift
//  Project7-We-petition
//
//  Created by Lucas Maniero on 22/02/22.
//

import WebKit

class DetailViewController: UIViewController {
    var webview: WKWebView!
    var detailItem: Petition?
    
    override func loadView() {
        webview = WKWebView()
        view = webview
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        goToUrl(detailItem?.url)
    }
    
    func goToUrl(_ stringUrl: String?) {
        guard let stringUrl = stringUrl,
              let url = URL(string: stringUrl)  else {
                  return
        }
        webview.load(URLRequest(url: url))
    }
    
    private func formatHMTLContent(_ content: String?) {
        guard let content = content else {
            return
        }
        
        let html = """
        <html>
        <head>
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <style> body { font-size: 150%; } </style>
        </head>
        <body>
        \(content)
        </body>
        </html>
        """
        
        webview.loadHTMLString(html, baseURL: nil)
    }
}
