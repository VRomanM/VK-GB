//
//  ConnectionSettings.swift
//  VK GB
//
//  Created by Роман Вертячих on 13.06.2022.
//

import Foundation

class Session {
    static let instance = Session()
    private init() { }
    
    var token: String = ""
    var userId: String = ""
}

class General {
    static let instance = General()
    private init() { }
    
    var needMigration = true
}
