//
//  WebLoginViewController.swift
//  VK GB
//
//  Created by Роман Вертячих on 15.06.2022.
//

import UIKit
import WebKit
import Alamofire

class WebLoginViewController: UIViewController {
    
    let session = Session.instance

    @IBOutlet weak var webview: WKWebView! {
        didSet{
            webview.navigationDelegate = self
        }
    }
    @IBAction func pushPhotoButton(_ sender: Any) {
        getPhotoByUserIDAF()
    }
    
    @IBAction func pushFriendsButton(_ sender: Any) {
        getFriendList()
    }
    
    @IBAction func pushGroupsButton(_ sender: Any) {
        getGroupsByUserIDAF()
        getGroupsByStringAF()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
    
    private func getFriendList() {
        // Конфигурация по умолчанию
        let configuration = URLSessionConfiguration.default // собственная сессия
        let sessionURL = URLSession(configuration: configuration)
        // создаем конструктор для url
        var urlConstructor = URLComponents()
        // устанавливаем схему
        urlConstructor.scheme = "https"
        // устанавливаем хост
        urlConstructor.host = "api.vk.com" // путь
        urlConstructor.path = "/method/friends.get" // параметры для запроса
        urlConstructor.queryItems = [
            URLQueryItem(name: "user_id", value: String(session.userId)),//value: Session.instance.userId),
            URLQueryItem(name: "owner_id", value: String(session.userId)),
            URLQueryItem(name: "access_token", value: session.token),
            URLQueryItem(name: "v", value: "5.131")
        ]
        let url = urlConstructor.url!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        let task = sessionURL.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error \(error.localizedDescription)")
                return
            }
            let json = try? JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments)
            print(json)
        }
        task.resume()
    }
    
    private func getPhotoByUserIDAF() {
        let url = "https://api.vk.com/method/photos.getProfile"
        let parameters: Parameters = [
            "owner_id": session.userId,
            "access_token": session.token,
            "v": "5.131"
        ]
        AF.request(url, method: .get, parameters: parameters).responseData { response in
            switch response.result {
            case .success(let data):
                do {
                    let json = try JSONSerialization.jsonObject(with: data)
                    print(json)
                } catch {
                    print("Error")
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func getGroupsByUserIDAF() {
        let url = "https://api.vk.com/method/groups.get"
        let parameters: Parameters = [
            "user_id": session.userId,
            "count": 10,
            "access_token": session.token,
            "v": "5.131"
        ]
        AF.request(url, method: .get, parameters: parameters).responseData { response in
            switch response.result {
            case .success(let data):
                do {
                    let json = try JSONSerialization.jsonObject(with: data)
                    print(json)
                } catch {
                    print("Error")
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func getGroupsByStringAF() {
        let url = "https://api.vk.com/method/groups.search"
        let parameters: Parameters = [
            "q": "Волейбол",
            "count": 10,
            "access_token": session.token,
            "v": "5.131"
        ]
        AF.request(url, method: .get, parameters: parameters).responseData { response in
            switch response.result {
            case .success(let data):
                do {
                    let json = try JSONSerialization.jsonObject(with: data)
                    print(json)
                } catch {
                    print("Error")
                }
            case .failure(let error):
                print(error)
            }
        }
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
        let token = params["access_token"]
        let session = Session.instance
        session.token = token ?? ""
        session.userId = params["user_id"] ?? "0"
        
        decisionHandler(.cancel)
    }
}
