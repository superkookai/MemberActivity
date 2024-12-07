//
//  NetworkService.swift
//  MemberActivity
//
//  Created by Weerawut Chaiyasomboon on 7/12/2567 BE.
//

import Foundation

enum NetworkError: Error{
    case badURL, badResponse, badData
}

struct NetworkService{
    static let shared = NetworkService()
    static var token: String?
    private init(){}
    
    func checkPhoneNumber(number: String) async throws{
        let endpoint = "https://duogo-api-nrt7sspxha-as.a.run.app/users/request-otp"
        guard let url = URL(string: endpoint) else { throw NetworkError.badURL }
                
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        let phone = PhoneDetail(identifier: number, method: "sms", action: "login")
        let data = try JSONEncoder().encode(phone)
        request.httpBody = data
        request.setValue(
            "application/json",
            forHTTPHeaderField: "Content-Type"
        )
        
        let (_,response) = try await URLSession.shared.data(for: request)
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.badResponse
        }
        print(httpResponse.statusCode)
        print(httpResponse)
    }
    
    func checkOTP(number: String, code: String) async throws {
        let endpoint = "https://duogo-api-nrt7sspxha-as.a.run.app/users/verify-otp"
        guard let url = URL(string: endpoint) else { throw NetworkError.badURL }
                
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        let otp = OtpDetail(identifier: number, code: code, action: "login")
        let data = try JSONEncoder().encode(otp)
        request.httpBody = data
        request.setValue(
            "application/json",
            forHTTPHeaderField: "Content-Type"
        )
        
        let (responseData,response) = try await URLSession.shared.data(for: request)
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.badResponse
        }
        
        do {
            let decodedResponse = try JSONDecoder().decode(OTPResponse.self, from: responseData)
            Self.token = decodedResponse.data.token
            print("Token: \(Self.token ?? "Not get token")")
            print("User ID: \(decodedResponse.data.user.id)")
        } catch {
            print("Failed to decode response: \(error.localizedDescription)")
            throw NetworkError.badData
        }
    }
    
    func getMembers() async throws -> [Member]{
        let endpoint = "https://duogo-api-nrt7sspxha-as.a.run.app/users/discover"
        guard let url = URL(string: endpoint) else { throw NetworkError.badURL }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        guard let token = Self.token else { throw NetworkError.badData }
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        let (data,response) = try await URLSession.shared.data(for: request)
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.badResponse
        }
        
//        if let jsonString = String(data: data, encoding: .utf8) {
//            print("Response JSON: \(jsonString)")
//        }
        
        //Decode JSON
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let wrapResponse = try decoder.decode(WrapResponse.self, from: data)
        let members: [Member] = wrapResponse.data
        print("Members: \(members)")
        
        return members
    }
    
    func getMembers(token: String) async throws -> [Member]{
        let endpoint = "https://duogo-api-nrt7sspxha-as.a.run.app/users/discover"
        guard let url = URL(string: endpoint) else { throw NetworkError.badURL }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        let (data,response) = try await URLSession.shared.data(for: request)
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.badResponse
        }
        
//        if let jsonString = String(data: data, encoding: .utf8) {
//            print("Response JSON: \(jsonString)")
//        }
        
        //Decode JSON
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let wrapResponse = try decoder.decode(WrapResponse.self, from: data)
        let members: [Member] = wrapResponse.data
        print("Members: \(members)")
        
        return members
    }
    
    static var preview: Member{
        Member(firstName: "Jerry", lastName: "Murray", gender: "male", about: "Dream garden item western mind.", city: "Bangkok", country:  "TH", invitation: nil, id: "670b3af78c6055a1b05cf3b8", photoURL: "https://randomuser.me/api/portraits/men/52.jpg", activities: [Activity(id: "670a807f8c6055a1b05cf353", name: "Coffee", category: "Social")])
    }
}

                                            
 
