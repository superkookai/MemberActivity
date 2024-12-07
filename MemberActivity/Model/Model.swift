//
//  Model.swift
//  MemberActivity
//
//  Created by Weerawut Chaiyasomboon on 7/12/2567 BE.
//

import Foundation

struct PhoneDetail: Codable{
    let identifier: String
    let method: String
    let action: String
}

struct OtpDetail: Codable{
    let identifier: String
    let code: String
    let action: String
}

struct OTPResponse: Decodable {
    let status: String
    let data: ResponseData
    
    struct ResponseData: Decodable {
        let token: String
        let user: UserInfo
    }
    
    struct UserInfo: Decodable {
        let id: String
    }
}

struct WrapResponse: Decodable{
    let data: [Member]
}

struct Member: Decodable, Identifiable{
    let firstName: String
    let lastName: String
    let gender: String
    let about: String
    let city: String
    let country: String
    let invitation: Bool?
    let id: String
    let photoURL: String
    let activities: [Activity]
}

struct Activity: Decodable, Identifiable{
    let id: String
    let name: String
    let category: String
}
