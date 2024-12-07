//
//  MemberListView.swift
//  MemberActivity
//
//  Created by Weerawut Chaiyasomboon on 7/12/2567 BE.
//

import SwiftUI

struct MemberListView: View {
    
    @State private var members: [Member] = []
    
    var body: some View {
        List{
            ForEach(members){ member in
                Text(member.firstName)
            }
        }
        .onAppear {
            Task{
                do{
                    self.members = try await NetworkService.shared.getMembers()
                }catch{
                    print("No data")
                }
            }
        }
    }
}

#Preview {
    MemberListView()
}
