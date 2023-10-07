//
//  LocationAlert.swift
//  SwiftUI-Weather
//
//  Created by Gemerson Ribas on 06/10/23.
//

import SwiftUI

struct LocationAlertView: View {
    
    @Binding var errorAlert: Bool
    let title, message: String
    
    var body: some View {
        VStack {}
        .onAppear{errorAlert = true}
        .onDisappear{ errorAlert = false }
        .alert(title, isPresented: $errorAlert, actions: {
            Button("OK", role: .destructive, action: {
                  errorAlert = false
              })
            }, message: {
              Text(message)
            }
        )
    }
}
