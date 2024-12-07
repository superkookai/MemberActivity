//
//  MemberDetailView.swift
//  MemberActivity
//
//  Created by Weerawut Chaiyasomboon on 7/12/2567 BE.
//

import SwiftUI

struct MemberDetailView: View {
    let member: Member
    
    var body: some View {
        VStack{
            Text("Hello 😁")
                .font(.largeTitle)
            
            AsyncImage(url: URL(string: member.photoURL)) { image in
                image
                    .clipShape(.circle)
            } placeholder: {
                Image(systemName: "person.circle")
            }
            
            Text(member.firstName)
                .font(.largeTitle)
        }
    }
}


