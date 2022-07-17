//
//  WebLoginViewController.swift
//  VK GB
//
//  Created by Роман Вертячих on 15.06.2022.
//

import UIKit
import WebKit
import Alamofire
import KeychainSwift
import FirebaseDatabase

class WebLoginViewController: UIViewController {
    
    let session = Session.instance

    @IBOutlet weak var webview: WKWebView! {
        didSet{
            webview.navigationDelegate = self
        }
    }
//    @IBAction func pushPhotoButton(_ sender: Any) {
//        getPhotoByUserIDAF()
//    }
//    
//    @IBAction func pushFriendsButton(_ sender: Any) {
//        getFriendList()
//    }
//    
//    @IBAction func pushGroupsButton(_ sender: Any) {
//        getGroupsByUserIDAF()
//        getGroupsByStringAF()
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let keychain = KeychainSwift()
        print(keychain.get("vk_access_token") ?? "NO ACCESS TOKEN")
        
        configureWebView()
    }
    
    func configureWebView() {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "oauth.vk.com"
        urlComponents.path = "/authorize"
        urlComponents.queryItems = [
            URLQueryItem(name: "client_id", value: "8194018"),
            URLQueryItem(name: "display", value: "mobile"),
            URLQueryItem(name: "redirect_uri", value: "https://oauth.vk.com/blank.html"),
            URLQueryItem(name: "scope", value: "262150"),
            URLQueryItem(name: "response_type", value: "token"),
            URLQueryItem(name: "v", value: "5.131") ]
        let request = URLRequest(url: urlComponents.url!)
        webview.load(request)
    }
}

extension WebLoginViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView,
                 decidePolicyFor navigationResponse:
                 WKNavigationResponse,
                 decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        guard let url = navigationResponse.response.url, url.path == "/blank.html", let fragment = url.fragment else {
            decisionHandler(.allow)
            return
        }
        let params = fragment
            .components(separatedBy: "&")
            .map { $0.components(separatedBy: "=") }
            .reduce([String: String]()) { result, param in
                var dict = result
                let key = param[0]
                let value = param[1]
                dict[key] = value
                return dict
            }
        session.token = params["access_token"] ?? ""
        session.userId = params["user_id"] ?? "0"
        
        let keychain = KeychainSwift()
        keychain.set(params["access_token"] ?? "", forKey: "vk_access_token")
     
        decisionHandler(.cancel)
        guard session.token != "" else { return }
        
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "vkTabBarController")
        self.present(vc, animated: true, completion: nil)
        
    }
}
