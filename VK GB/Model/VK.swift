//
//  VK.swift
//  VK GB
//
//  Created by Роман Вертячих on 10.05.2022.
//

import UIKit

class GroupVK: Equatable, CustomStringConvertible, Codable {
    static func == (lhs: GroupVK, rhs: GroupVK) -> Bool {
        let areEqual = lhs.id == rhs.id && lhs.imageName == rhs.imageName
        return areEqual
    }
    
    let id: Int
    let imageName: String
    let name: String
    var check: Bool = false
    
    init (id: Int, name: String, imageName: String) {
        self.id = id
        self.name = name
        self.imageName = imageName
    }
    
    required init(from decoder: Decoder) throws {
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
    
    var description: String {
        return """
        Id: \(self.id)
        Name: \(self.name)
        Photo: \(self.imageName)
        """
    }
}

class UserVK: Equatable, CustomStringConvertible {
    static func == (lhs: UserVK, rhs: UserVK) -> Bool {
        let areEqual = lhs.id == rhs.id
        return areEqual
    }
    
    let id: Int
    var image: UIImage = UIImage(systemName: "photo")!
    var check: Bool = false
    var fullName: String = ""
    var firstName: String = ""
    var lastName: String = ""
    var photo = [Photo]()
    
    init (id: Int, image: UIImage){
        self.id = id
        self.image = image
        self.fullName = "\(lastName) \(firstName)"
        
        if firstName == "Заюнька" {
            self.photo = [
                Photo(id: "person.wave.2", description: "На море", like: 2),
                Photo(id: "person.wave.2.fill", description: "На природе", like: 4),
                Photo(id: "person.2.wave.2", description: "Дома", like: 0)
            ]
        }
    }
    
    init (id: Int, firstName: String, lastName: String){
        self.id = id
        self.firstName = firstName
        self.lastName = lastName
    }
    
    init (id: Int, imageSysName: String){
        self.id = id
        self.image = UIImage(systemName: imageSysName)!
        if firstName == "Заюнька" {
            self.photo = [
                Photo(id: "person.wave.2", description: "На море", like: 2),
                Photo(id: "person.wave.2.fill", description: "На природе", like: 4),
                Photo(id: "person.2.wave.2", description: "Дома", like: 0)
            ]
        }
    }
    
    init (json: Any) {
        let userDict = json as! [String: Any]
        self.id = userDict["id"] as! Int
        self.firstName = userDict["first_name"] as! String
        self.lastName = userDict["last_name"] as! String
        self.fullName = "\(self.lastName) \(self.firstName)"
    }
    
    var description: String {
        return """
        id: \(self.id)
        first name: \(self.firstName)
        """
    }
}

class Photo {
    let id: String
    let description: String
    var like: UInt8
    var myLike: UInt8 = 0
    
    init (id: String, description: String, like: UInt8) {
        self.id = id
        self.description = description
        self.like = like
    }
}

class News {
    let title: String
    let text: String
    var like: UInt8
    var myLike: UInt8 = 0
    let photo: [Photo]
    
    init (title: String, text: String, like: UInt8, photo: [Photo]) {
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
