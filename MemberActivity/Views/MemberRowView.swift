//
//  MemberRowView.swift
//  MemberActivity
//
//  Created by Weerawut Chaiyasomboon on 7/12/2567 BE.
//

import SwiftUI
import Flow

struct MemberRowView: View {
    let member: Member
    
    var body: some View {
        HStack(alignment: .top, spacing: 10){
            AsyncImage(url: URL(string: member.photoURL)) { image in
                image
                    .resizable()
                    .scaledToFill()
                    .frame(width: 60, height: 60)
                    .clipShape(.circle)
            } placeholder: {
                Image(systemName: "person.circle")
                    .resizable()
                    .frame(width: 60, height: 60)
            }
            
            VStack(alignment: .leading){
                Text(member.firstName)
                    .font(.system(size: 15))
                    .fontWeight(.semibold)
                
                Text(member.city)
                    .font(.system(size: 15))
                    .foregroundStyle(.secondary)
                
                HFlow(alignment: .top){
                    ForEach(member.activities){ activity in
                        ActivityView(activity: activity)
                    }
                }
            }
            
            Spacer()
        }
        .frame(maxWidth: .infinity)
    }
}

struct ActivityView: View {
    let activity: Activity
    
    var body: some View {
        Text(activity.name)
            .font(.system(size: 7))
            .foregroundStyle(.white)
            .padding(7)
            .background(.gray.opacity(0.4))
            .clipShape(.rect(cornerRadius: 5))
    }
}

#Preview {
    MemberRowView(member: NetworkService.preview)
}

#Preview {
    ActivityView(activity: NetworkService.preview.activities[0])
}
