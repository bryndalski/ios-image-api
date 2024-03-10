//
//  CognitoUser.protocol.swift
//  zaliczenie_bryndal
//
//  Created by Jakub Bryndal on 10/03/2024.
//

import Foundation

protocol CognitoUser {
    var familyName:String {get set}
    var givenName: String {get set}
    var email: String {get set}
}
