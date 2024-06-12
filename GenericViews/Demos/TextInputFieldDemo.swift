//
//  TextInputFieldDemo.swift
//  GenericViews
//
//  Created by Toka Elkeik on 12/06/2024.
//

import SwiftUI

struct TextInputFieldDemo: View {
    var body: some View {
        VStack {
            BeautisryTextField()
        }
    }
}

struct BeautisryTextField: View {
    @State private var firstName: String = ""
    @State private var lastName: String = ""
    
    var body: some View {
        VStack{
            Spacer().frame(height: 50)
            TextInputField(title: "First Name",
                           text: $firstName,
                           placeholderText: "Enter First Name")
            .textInputFieldConfiguration(
                TextInputFieldConfiguration(
                    general: Constants.generalTextConfiguration,
                    errorMessageConfiguration: Constants.errorMessageConfiguration,
                    titleConfiguration: Constants.titleConfiguration,
                    addClearButton: true
                ))
            .onValidate(validationHandler: ValidationManager.validateTextLength)
            
            Spacer().frame(height: 10)
            
            TextInputField(title: "Password",
                           text: $lastName,
                           placeholderText: "Enter Your Password",
                           isSecure: true)
            
            .textInputFieldConfiguration(
                TextInputFieldConfiguration(
                    general: Constants.generalTextConfiguration,
                    errorMessageConfiguration: Constants.errorMessageConfiguration,
                    titleConfiguration: Constants.titleConfiguration,
                    submitLabel: .done
                ))
            .onValidate(validationHandler: ValidationManager.validatePasswordLength)
            
            Spacer()
        }
        .padding(.horizontal, 20)
       
        
    }
}

// MARK: - Constants
struct Constants {
    static var generalTextConfiguration = GeneralTextInputFieldConfiguration(
        backgroundColor: .clear,
        textColor: .black,
        font: .system(size: 16),
        cornerRadius: 8,
        borderColor: .gray,
        borderWidth: 1,
        padding: EdgeInsets(top: 12, leading: 14, bottom: 12, trailing: 14)
    )
    
    static var titleConfiguration = InputFieldTitleConfiguration(
        titleFont: .system(size: 16, weight: .bold),
        titleColor: .black,
        titleBottomPadding: 6
    )
    
    static var errorMessageConfiguration = ErrorMessageConfiguration(
        font: .system(size: 12),
        color: .red,
        leadingPadding: 10,
        topPadding: 5)
}

// MARK: - ValidationMethods
struct ValidationManager {
    static func validateTextLength(_ text: String) -> Result<Bool, ValidationError> {
        if text.count >= 3 {
            return .success(true)
        } else {
            return .failure(ValidationError(message: "Text must be at least 3 characters long"))
        }
    }
    
    static func validatePasswordLength(_ text: String) -> Result<Bool, ValidationError> {
        if text.count >= 3 {
            return .success(true)
        } else {
            return .failure(ValidationError(message: "password must be at least 5 characters long"))
        }
    }
}

#Preview {
    TextInputFieldDemo()
}
