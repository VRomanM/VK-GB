//
//  VK.swift
//  VK GB
//
//  Created by Роман Вертячих on 10.05.2022.
//

import UIKit

class VKData: Equatable {
    static func == (lhs: VKData, rhs: VKData) -> Bool {
        let areEqual = lhs.id == rhs.id && lhs.imageName == rhs.imageName
        return areEqual
    }
    
    var id: String
    var imageName: String
    var check: Bool = false
    var fullName: String = ""
    
    init (id: String, imageName: String){
        self.id = id
        self.imageName = imageName
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
