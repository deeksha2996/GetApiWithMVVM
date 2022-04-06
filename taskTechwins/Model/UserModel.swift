//
//  UserModel.swift
//  taskTechwins
//
//  Created by Akshay Sharma on 05/04/22.
//

import Foundation

struct UserModel: Codable {
    let statusCode : Int?
    let message : String?
    let data : UserData?
}

struct UserData : Codable {
    let username : String?
    let name : String?
    let email : String?
    let password : String?
    let device_token : String?
    let device_type : Int?

    enum CodingKeys: String, CodingKey {

        case username = "username"
        case name = "name"
        case email = "email"
        case password = "password"
        case device_token = "device_token"
        case device_type = "device_type"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        username = try values.decodeIfPresent(String.self, forKey: .username)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        email = try values.decodeIfPresent(String.self, forKey: .email)
        password = try values.decodeIfPresent(String.self, forKey: .password)
        device_token = try values.decodeIfPresent(String.self, forKey: .device_token)
        device_type = try values.decodeIfPresent(Int.self, forKey: .device_type)
    }

}
