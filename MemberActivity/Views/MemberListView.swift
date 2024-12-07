//
//  MemberListView.swift
//  MemberActivity
//
//  Created by Weerawut Chaiyasomboon on 7/12/2567 BE.
//

import SwiftUI

struct MemberListView: View {
        
    @AppStorage("token") var token: String?
    @State private var members: [Member] = []
    
    var body: some View {
        NavigationStack {
            List{
                ForEach(members){ member in
                    NavigationLink {
                        //Destination
                        MemberDetailView(member: member)
                    } label: {
                        MemberRowView(member: member)
                    }
                }
                .listStyle(.plain)
            }
            .navigationTitle("Explore")
        }
        .onAppear {
            Task{
                do{
                    if let token{
                        members = try await NetworkService.shared.getMembers(token: token)
                    }else{
                        members = try await NetworkService.shared.getMembers()
                    }
                }catch{
                    print("Error get members: \(error.localizedDescription)")
                }
            }
        }
    }
}

#Preview {
    MemberListView()
}
