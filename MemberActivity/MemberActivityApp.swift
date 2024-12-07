//
//  MemberActivityApp.swift
//  MemberActivity
//
//  Created by Weerawut Chaiyasomboon on 7/12/2567 BE.
//

import SwiftUI

@main
struct MemberActivityApp: App {
    @AppStorage("token") var token: String?
    
    var body: some Scene {
        WindowGroup {
            if let token {
                MainView()
            }else{
                LoginPhoneView()
            }
        }
    }
}
