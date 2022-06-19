//
//  ApiVK.swift
//  VK GB
//
//  Created by Роман Вертячих on 18.06.2022.
//

import Foundation
import WebKit
import Alamofire
import SwiftyJSON

class ApiVK {
    //init() { }
    
    // MARK: - Friends
    
    func getFriendList(completion: @escaping ([UserVK]) -> Void) {
        let session = Session.instance
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
            //URLQueryItem(name: "count", value: "10"),
            URLQueryItem(name: "fields", value: "nickname"),
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
            let json = try! JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments)
            
            let objectJSON = json as! [String: Any]
            let response = objectJSON["response"] as! [String: Any]
            //let count = response["count"] as! Int
            let items = response["items"] as! [[String: Any]]
            var users = [UserVK]()
            for item in items {
                let user = UserVK(json: item)
                if user.firstName != "DELETED" {
                    users.append(user)
                }
            }
            completion(users)
            //print(users)
            //print(json)
        }
        task.resume()
    }
    
    // MARK: - Groups
    
    func getGroupsByUserIDAF(completion: @escaping ([GroupVK]) -> Void ) {
        let session = Session.instance
        let url = "https://api.vk.com/method/groups.get"
        let parameters: Parameters = [
            "user_id": session.userId,
            "extended": 1,
            "access_token": session.token,
            "v": "5.131"
        ]
        AF.request(url, method: .get, parameters: parameters).responseData { response in
            switch response.result {
            case .success(let data):
                do {
                    let json = JSON(data)
                    let groups = json["response"]["items"].arrayValue.map {
                        GroupVK(id: $0["id"].intValue, name: $0["name"].stringValue, imageName: $0["photo50"].stringValue)
                    }
                    //                let items = json["response"]["items"]
                    //                var groups = [GroupVK]()
                    //                for item in items.arrayValue {
                    //                    groups.append(GroupVK(id: item["id"].intValue,
                    //                                          name: item["name"].stringValue,
                    //                                          imageName: item["photo50"].stringValue))
                    //                }
                    //print(groups)
                    completion(groups)
                } catch {
                    print("Error")
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func getGroupsByStringAF(str: String, completion: @escaping ([GroupVK]) -> Void ) {
        let session = Session.instance
        let url = "https://api.vk.com/method/groups.search"
        let parameters: Parameters = [
            "q": str,
            "count": 10,
            "access_token": session.token,
            "v": "5.131"
        ]
        AF.request(url, method: .get, parameters: parameters).responseData { response in
            switch response.result {
            case .success(let data):
                do {
                    let response = try JSONDecoder().decode(VKResponse.self, from: data).values
                    //print(response)
                    completion(response)
                } catch {
                    print("Error")
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    // MARK: - Photo
    
    func getPhotoByUserIDAF() {
        let session = Session.instance
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
    
//    required init(from decoder: Decoder) throws {
//        let lvl1Container = try decoder.container(keyedBy: lvl1CoodingKeys.self)
//        let lvl2Container = try lvl1Container.nestedContainer(keyedBy: lvl2CoodingKeys.self, forKey: .response)
//        self.response = try lvl2Container.nestedUnkeyedContainer(forKey: .items)
//    }
//
//    enum lvl1CoodingKeys: String, CodingKey {
//        case response
//    }
//    enum lvl2CoodingKeys: String, CodingKey {
//        case items
//    }
}
