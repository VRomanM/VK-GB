//
//  VK.swift
//  VK GB
//
//  Created by Роман Вертячих on 10.05.2022.
//

import UIKit
import RealmSwift

class GroupVK: Object, Codable {
    static func == (lhs: GroupVK, rhs: GroupVK) -> Bool {
        let areEqual = lhs.id == rhs.id && lhs.imageName == rhs.imageName
        return areEqual
    }
        
    @Persisted var id: Int
    @Persisted var imageName: String
    @Persisted var name: String
    var check: Bool = false
    
    override class func primaryKey() -> String? {
        "id"
    }
    
    convenience init (id: Int, name: String, imageName: String) {
        self.init()
        self.id = id
        self.name = name
        self.imageName = imageName
    }
    
    convenience required init(from decoder: Decoder) throws {
        self.init()
        let Container = try decoder.container(keyedBy: CoodingKeys.self)
        self.id = try Container.decode(Int.self, forKey: .id)
        self.name = try Container.decode(String.self, forKey: .name)
        self.imageName = try Container.decode(String.self, forKey: .imageName)
    }
    
    enum CoodingKeys: String, CodingKey {
        case id, name
        case imageName = "photo_50"
    }
    
    enum lvl1CoodingKeys: String, CodingKey {
        case response
    }
    enum lvl2CoodingKeys: String, CodingKey {
        case items
    }
    
    override var description: String {
        return """
        Id: \(self.id)
        Name: \(self.name)
        Photo: \(self.imageName)
        """
    }
}

class UserVK: Object { //Equatable
    static func == (lhs: UserVK, rhs: UserVK) -> Bool {
        let areEqual = lhs.id == rhs.id
        return areEqual
    }
    
    @Persisted var id: Int = 0
    var image: UIImage = UIImage(systemName: "photo")!
    @Persisted var check: Bool = false
    @Persisted var fullName: String = ""
    @Persisted var firstName: String = ""
    @Persisted var lastName: String = ""
    var photo = [Photo]()
    var urlPath = ""
    
    override class func primaryKey() -> String? {
        "id"
    }
    
    convenience init (id: Int, image: UIImage){
        self.init()
        self.id = id
        self.image = image
        self.fullName = "\(lastName) \(firstName)"
        
        if firstName == "Заюнька" {
            self.photo = [
                Photo(id: 1, urlPath: "На море", like: 2),
                Photo(id: 2, urlPath: "На природе", like: 4),
                Photo(id: 3, urlPath: "Дома", like: 0)
            ]
        }
    }
    
    convenience init (id: Int, firstName: String, lastName: String){
        self.init()
        self.id = id
        self.firstName = firstName
        self.lastName = lastName
    }
    
    convenience init (id: Int, imageSysName: String){
        self.init()
        self.id = id
        self.image = UIImage(systemName: imageSysName)!
//        if firstName == "Заюнька" {
//            self.photo = [
//                Photo(id: "person.wave.2", description: "На море", like: 2),
//                Photo(id: "person.wave.2.fill", description: "На природе", like: 4),
//                Photo(id: "person.2.wave.2", description: "Дома", like: 0)
//            ]
//        }
    }
    
    convenience init (json: Any) {
        self.init()
        let userDict = json as! [String: Any]
        self.id = userDict["id"] as! Int
        self.firstName = userDict["first_name"] as! String
        self.lastName = userDict["last_name"] as! String
        self.fullName = "\(self.lastName) \(self.firstName)"
        self.urlPath = userDict["photo_50"] as! String
    }
    
    override var description: String {
        return """
        id: \(self.id)
        first name: \(self.firstName)
        """
    }
}

class Photo: Object {
    @Persisted var id: Int
    @Persisted var urlPath: String
    @Persisted var like: Int
    //@Persisted var myLike = 0
    
    override class func primaryKey() -> String? {
        "id"
    }
    
    convenience init (id: Int, urlPath: String, like: Int) {
        self.init()
        self.id = id
        self.urlPath = urlPath
        self.like = like
    }
}

class News: Object {
    @Persisted var title: String = ""
    @Persisted var text: String = ""
    @Persisted var like: Int = 0
    @Persisted var myLike = 0
    var photo: [Photo] = []
    
    override class func primaryKey() -> String? {
        "title"
    }
    
    convenience init (title: String, text: String, like: Int, photo: [Photo]) {
        self.init()
        self.title = title
        self.text = text
        self.like = like
        self.photo = photo
    }
}

/// Возвращает индекс найденной строки в массиве
/// - Parameters:
///   - searchValue: искомое значение
///   - array: массив значений
/// - Returns: индекс. Если значение не удалось найти, возвращается nil
func find<T:Equatable>(value searchValue: T, in array: [T]) -> Int? {
    for (index, value) in array.enumerated() {
        if value == searchValue {
            return index
        }
    }
    return nil
}
