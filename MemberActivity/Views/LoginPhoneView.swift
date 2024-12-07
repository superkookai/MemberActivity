//
//  LoginPhoneView.swift
//  MemberActivity
//
//  Created by Weerawut Chaiyasomboon on 7/12/2567 BE.
//

import SwiftUI

struct LoginPhoneView: View {
    let networkService: NetworkService = NetworkService.shared

    @State private var phoneNumber: String = ""
    @State private var isPhoneCorrect: Bool = false
    @State private var isShowAlert: Bool = false
    
    var body: some View {
        VStack{
            Text("Login")
                .font(.largeTitle)
            
            Text("Enter your phone number to continue")
                .font(.headline)
            
            TextField("Phone Number", text: $phoneNumber)
                .font(.title3)
                .padding()
                .textFieldStyle(.roundedBorder)
                .keyboardType(.phonePad)
            
            
            Button {
                Task{
                    do{
                        try await networkService.checkPhoneNumber(number: phoneNumber)
                        isPhoneCorrect = true
                    }catch{
                        print("Error: \(error.localizedDescription)")
                        isPhoneCorrect = false
                        isShowAlert = true
                    }
                    
                }
            } label: {
                Text("Continue")
                    .frame(maxWidth: .infinity)
            }
            .buttonStyle(.borderedProminent)
            .padding(.horizontal)
            .disabled(phoneNumber.isEmpty)

        }
        .fullScreenCover(isPresented: $isPhoneCorrect) {
            LoginOTPConfirmView(phoneNumber: phoneNumber)
        }
        .alert("Phone number error", isPresented: $isShowAlert) {
            
        }
    }
    
    
}

#Preview {
    LoginPhoneView()
}
