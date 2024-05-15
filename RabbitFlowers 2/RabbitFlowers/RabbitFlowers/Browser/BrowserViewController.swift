//
//  BrowserViewController.swift
//  RabbitFlowers
//
//  Created by Иван Незговоров on 23.04.2024.
//

import UIKit
import WebKit

class BrowserViewController: UIViewController {
    
    lazy var webView: WKWebView = {
        let wv = WKWebView()
        wv.translatesAutoresizingMaskIntoConstraints = false
        wv.navigationDelegate = self
        return wv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    func setup() {
        setupWebView()
        setupToolBar()
        setupNavBar()
    }
}

// MARK: -- Layout
extension BrowserViewController {
    func setupWebView() {
        view.addSubview(webView)
      
        guard let urlString = URL(string: "https://rabbitflowers.kz") else { return }
        webView.load(URLRequest(url: urlString))
        
        NSLayoutConstraint.activate([
            webView.topAnchor.constraint(equalTo: view.topAnchor),
            webView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            webView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            webView.leadingAnchor.constraint(equalTo: view.leadingAnchor)
        ])
    }
    
    func setupToolBar() {
        var buttons = [UIBarButtonItem]()
        let apps = UIToolbarAppearance()
        apps.configureWithOpaqueBackground()
        apps.backgroundColor = allColorsPattern.whiteColor
        navigationController?.toolbar.standardAppearance = apps
        navigationController?.toolbar.tintColor = allColorsPattern.baseColor
        buttons.append(UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil))
        buttons.append(UIBarButtonItem(image:  UIImage(systemName: "arrowshape.backward.fill"), style: .done, target: self, action: #selector(backButton)))
        buttons.append(UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil))
        buttons.append(UIBarButtonItem(image:  UIImage(systemName: "gobackward"), style: .done, target: self, action: #selector(reloadButton)))
        buttons.append(UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil))
        buttons.append(UIBarButtonItem(image:  UIImage(systemName: "arrowshape.forward.fill"), style: .done, target: self, action: #selector(forwardButton)))
        buttons.append(UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil))
        self.toolbarItems = buttons
        navigationController?.setToolbarHidden(false, animated: true)
    }
    
    func setupNavBar() {
        navigationController?.navigationBar.tintColor = allColorsPattern.blackColor
    }
}

// MARK: -- OBJC
extension BrowserViewController {
    @objc func backButton() {
        if webView.canGoBack {
            webView.goBack()
        }
    }
    
    @objc func forwardButton() {
        if webView.canGoForward {
            webView.goForward()
        }
    }
    
    @objc func reloadButton() {
        webView.reload()
    }
}

// MARK: -- WKNavigationDelegate
extension BrowserViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        Alerts.shared.alertDialog(presenter: self, title: "Error", description: "Error with loading site")
    }
}
