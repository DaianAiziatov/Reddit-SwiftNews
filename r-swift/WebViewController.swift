//
//  WebViewController.swift
//  r-swift
//
//  Created by Daian Aziatov on 2020-06-10.
//  Copyright © 2020 Daian Aziatov. All rights reserved.
//

import UIKit
import WebKit

class WebViewController: UIViewController {

    var urlToOpen: URL

    init(urlToOpen: URL) {
        self.urlToOpen = urlToOpen
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private let webView = WKWebView()
    private let progressView = UIProgressView()
    private let toolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 35))

    override func viewDidLoad() {
        super.viewDidLoad()
        let stackView = UIStackView(arrangedSubviews: [toolBar, progressView, webView])
        stackView.axis = .vertical
        view.addSubview(stackView)
        stackView.embed(in: view)
        setupNavigationBar()
        setupWebView()
    }

    private func setupNavigationBar() {
        let action = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(didTapActions))
        let close = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(didTapClose))
        let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        toolBar.setItems([close, space, action], animated: false)
    }

    private func setupWebView() {
        webView.navigationDelegate = self
        webView.uiDelegate = self
        webView.allowsBackForwardNavigationGestures = true
        webView.load(URLRequest(url: urlToOpen))
    }

    @objc
    private func didTapActions() {
        guard let url = webView.url else {
            return
        }
        let activityVC = UIActivityViewController(activityItems: [url], applicationActivities: nil)
        present(activityVC, animated: true)
    }

    @objc
    private func didTapClose() {
        dismiss(animated: true)
    }

}

extension WebViewController: WKNavigationDelegate {
    func webView(_: WKWebView, didStartProvisionalNavigation _: WKNavigation!) {
        progressView.setProgress(0.1, animated: false)
    }

    func webView(_: WKWebView, didFinish _: WKNavigation!) {
        progressView.setProgress(1, animated: true)
    }

    func webView(_: WKWebView, didFail _: WKNavigation!, withError _: Error) {
        progressView.setProgress(1, animated: true)
        navigationController?.dismiss(animated: true)
    }
}

extension WebViewController: WKUIDelegate {
    func webView(_ webView: WKWebView, createWebViewWith _: WKWebViewConfiguration, for navigationAction: WKNavigationAction, windowFeatures _: WKWindowFeatures) -> WKWebView? {
        webView.load(navigationAction.request)
        return nil
    }
}
