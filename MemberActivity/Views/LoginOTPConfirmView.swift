//
//  LoginOTPConfirmView.swift
//  MemberActivity
//
//  Created by Weerawut Chaiyasomboon on 7/12/2567 BE.
//

import SwiftUI

struct LoginOTPConfirmView: View {
    let networkService: NetworkService = NetworkService.shared
    @Environment(\.dismiss) var dismiss
    
    let phoneNumber: String
    @State private var otpCode: String = ""
    @State private var isLoginSuccess: Bool = false
    @State private var token = ""
    
    var body: some View {
        VStack{
            Text("Login")
                .font(.largeTitle)
            
            Text("Enter the code we've sent you")
                .font(.headline)
            
            TextField("Code", text: $otpCode)
                .font(.title3)
                .padding()
                .textFieldStyle(.roundedBorder)
                .keyboardType(.numberPad)
            
            
            Button {
                Task{
                    do{
                        try await networkService.checkOTP(number: phoneNumber, code: otpCode)
                        isLoginSuccess = true
                    }catch{
                        print("Error: \(error.localizedDescription)")
                        isLoginSuccess = false
                    }
                }
            } label: {
                Text("Confirm")
                    .frame(maxWidth: .infinity)
            }
            .buttonStyle(.borderedProminent)
            .padding(.horizontal)
            .disabled(otpCode.isEmpty)
            
            Button {
                dismiss()
            } label: {
                Text("Go back")
                    .frame(maxWidth: .infinity)
            }
            .padding()

        }
        .fullScreenCover(isPresented: $isLoginSuccess) {
            MainView()
        }
    }
    
}

#Preview {
    LoginOTPConfirmView(phoneNumber: "")
}
