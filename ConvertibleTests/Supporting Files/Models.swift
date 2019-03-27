//
//  Models.swift
//  Convertible
//
//  Created by Bradley Hilton on 6/25/15.
//  Copyright © 2015 Skyvive. All rights reserved.
//

import Convertible

struct PersonValue : Convertible, UnderscoreToCamelCase, Codable {
    lazy var id: Int = 0
    var firstName: String?
    var lastName: String?
    var `public`: Bool?
}

final class Person : Convertible, UnderscoreToCamelCase {
    var id: Int
    var firstName: String
    var lastName: String
    var `public`: Bool
    var bestFriend: Person?
    init() { fatalError() }
}

final class RequiredKeysPerson : Convertible, UnderscoreToCamelCase {
    var firstName: String? = "Brad"
    var lastName: String? = "Hilton"
    var isPublic: Bool? = false
    var age: Int? = 26
    required init() {}
}
