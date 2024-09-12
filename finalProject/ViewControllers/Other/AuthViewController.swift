//
//  AuthViewController.swift
//  finalProject
//
//  Created by Pavel Plyago on 10.08.2024.
//

import UIKit
import WebKit

class AuthViewController: UIViewController, WKNavigationDelegate {
    
    private let webView: WKWebView = {
        let webView = WKWebView(frame: .zero)
        webView.translatesAutoresizingMaskIntoConstraints = false
        return webView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        webView.navigationDelegate = self
        view.addSubview(webView)
        
        guard let url = AuthManager.shared.signInURL else {
            return
        }
        webView.load(URLRequest(url: url))
        
        webView.snp.makeConstraints {
            $0.trailing.leading.equalToSuperview()
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
    }
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        guard let url = webView.url else {
            return
        }
        
        let components = URLComponents(string: url.absoluteString)
        guard let code = components?.queryItems?.first(where: {$0.name == "code"})?.value else {
            return
        }
        
        webView.isHidden = true
        
        AuthManager.shared.exchageCodeForToken(code: code) {[weak self] success in
            DispatchQueue.main.async {
                if success {
                    let vc = TabBarViewController()
                    vc.modalPresentationStyle = .fullScreen
                    self?.present(vc, animated: true)
                } else {
                    print("Token exchange failed")
                }
            }
        }
        
    }

}
