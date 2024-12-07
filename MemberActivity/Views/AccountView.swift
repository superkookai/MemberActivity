//
//  AccountView.swift
//  MemberActivity
//
//  Created by Weerawut Chaiyasomboon on 7/12/2567 BE.
//

import SwiftUI

struct AccountView: View {
    @AppStorage("token") var token: String?
    
    var body: some View {
        NavigationStack {
            List{
                Text("John Doe")
                
                Button {
                    token = nil
                } label: {
                    Text("Logout")
                }

            }
            .navigationTitle("My Account")
        }
    }
}

#Preview {
    AccountView()
}
