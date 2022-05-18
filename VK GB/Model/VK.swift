//
//  VK.swift
//  VK GB
//
//  Created by Роман Вертячих on 10.05.2022.
//

import UIKit

class GroupVK: Equatable {
    static func == (lhs: GroupVK, rhs: GroupVK) -> Bool {
        let areEqual = lhs.id == rhs.id && lhs.imageName == rhs.imageName
        return areEqual
    }
    
    let id: String
    let imageName: String
    var check: Bool = false
    
    init (id: String, imageName: String){
        self.id = id
        self.imageName = imageName
    }
}

class UserVK: Equatable {
    static func == (lhs: UserVK, rhs: UserVK) -> Bool {
        let areEqual = lhs.id == rhs.id
        return areEqual
    }
    
    let id: String
    var image: UIImage = UIImage(systemName: "photo")!
    var check: Bool = false
    let fullName: String = ""
    var photo = [Photo]()
    
    init (id: String, image: UIImage){
        self.id = id
        self.image = image
        if id == "Заюнька" {
            self.photo = [
                            Photo(id: "person.wave.2", description: "На море", like: 2),
                            Photo(id: "person.wave.2.fill", description: "На природе", like: 4),
                            Photo(id: "person.2.wave.2", description: "Дома", like: 0)
                        ]
        }
    }
    
    init (id: String, imageSysName: String){
        self.id = id
        self.image = UIImage(systemName: imageSysName)!
        if id == "Заюнька" {
            self.photo = [
                            Photo(id: "person.wave.2", description: "На море", like: 2),
                            Photo(id: "person.wave.2.fill", description: "На природе", like: 4),
                            Photo(id: "person.2.wave.2", description: "Дома", like: 0)
                        ]
        }
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
