//
//  ApiVKResponse.swift
//  VK GB
//
//  Created by Роман Вертячих on 19.06.2022.
//

import Foundation

class VKResponse: Decodable {
    var values: [GroupVK] = []
    
    required convenience init(from decoder: Decoder) throws {
        self.init()
        let lvl1Container = try decoder.container(keyedBy: lvl1CoodingKeys.self)
        let lvl2Container = try lvl1Container.nestedContainer(keyedBy: lvl2CoodingKeys.self, forKey: .response)
        self.values = try lvl2Container.decode([GroupVK].self, forKey: .items)
        
    }
    
    enum lvl1CoodingKeys: String, CodingKey {
        case response
    }
    
    enum lvl2CoodingKeys: String, CodingKey {
        case items
    }
}



