//
//  ContentView.swift
//  GenericViews
//
//  Created by Toka Elkeik on 06/06/2024.
//

import SwiftUI

struct ContentView: View {
    @State var text = ""
    
    var body: some View {
        
        VStack {
            TextInputField(title: "Enter Your Email",
                           text:  $text,
                           placeholderText: "Enter your name")
                
               
        }
        .padding()
        Spacer()
    }
    
    func validateTextLength(_ text: String) -> Result<Bool, ValidationError> {
        if text.count >= 3 {
            return .success(true)
        } else {
            return .failure(ValidationError(message: "Text must be at least 3 characters long"))
        }
    }
}

#Preview {
    ContentView()
}
