//
//  ContentView.swift
//  MemberActivity
//
//  Created by Weerawut Chaiyasomboon on 7/12/2567 BE.
//

import SwiftUI

struct MainView: View {

    var body: some View {
        TabView {
            MemberListView()
                .tabItem {
                    Image(systemName: "wand.and.rays")
                    Text("Explore")
                }
            
            AccountView()
                .tabItem {
                    Image(systemName: "person.crop.circle")
                    Text("Account")
                }
        }
    }
}

#Preview {
    MainView()
}
