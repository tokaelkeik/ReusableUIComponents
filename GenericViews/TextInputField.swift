//
//  TextInputField.swift
//  GenericViews
//
//  Created by Toka Elkeik on 09/06/2024.
//

import SwiftUI

// MARK: - TextInputField
struct TextInputField: View {
    @Binding var text: String
    var title: String
    var placeholderText: String
    var isSecure: Bool
  
    @Binding private var isValidBinding: Bool
    @State private var isValid: Bool = true {
        didSet {
            isValidBinding = isValid
        }
    }
    @State private var validationMessage: String = ""
    @State private var borderColor: Color = .gray
 
    @Environment(\.textInputFieldConfiguration) var configuration: TextInputFieldConfiguration
    @Environment(\.validationHandler) var validationHandler
    
    public init(title: String = "",
                text: Binding<String>,
                placeholderText: String = "",
                isSecure: Bool = false,
                isValid isValidBinding: Binding<Bool> = .constant(true)) {
        self.title = title
        self._text = text
        self.placeholderText = placeholderText
        self.isSecure = isSecure
        self._isValidBinding = isValidBinding
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            if title != "" {
                Text(title)
                    .font(configuration.titleConfiguration.titleFont)
                    .foregroundColor(configuration.titleConfiguration.titleColor)
                    .padding(.bottom, configuration.titleConfiguration.titleBottomPadding)
            }
            if isSecure {
                SecureTextInputField(text: $text,
                                     placeholderText: placeholderText,
                                     configuration: configuration,
                                     borderColor: $borderColor)
                .overlay(clearButton)
                .onChange(of: text) { value in
                    validate(value)
                }
                   
            } else {
                RegularTextInputField(text: $text,
                                      placeholderText: placeholderText,
                                      configuration: configuration,
                                      borderColor: $borderColor)
                .overlay(clearButton)
                .onChange(of: text) { value in
                    validate(value)
                }
            }
            
            Text(isValid ? "" : validationMessage)
                .font(configuration.errorMessageConfiguration.font)
                .foregroundColor(configuration.errorMessageConfiguration.color)
                .padding(.leading, configuration.errorMessageConfiguration.leadingPadding)
                .padding(.top, configuration.errorMessageConfiguration.topPadding)
        }
    }
    
    fileprivate func validate(_ value: String) {
        isValid = true
        
        if isValid {
            guard let validationHandler = self.validationHandler else { return }
            
            let validationResult = validationHandler(value)
            
            if case .failure(let error) = validationResult {
                isValid = false
                self.borderColor = configuration.general.errorBorderColor
                self.validationMessage = "\(error.localizedDescription)"
            }
            else if case .success(let isValid) = validationResult {
                self.isValid = isValid
                self.validationMessage = ""
                self.borderColor = configuration.general.successBorderColor
            }
        }
    }
    
    var clearButton: some View {
        HStack {
            if configuration.leftButtonConfiguration.addButton {
                Spacer()
                Button(action: { configuration.leftButtonConfiguration.action?() }) {
                    configuration.leftButtonConfiguration.image
                        .foregroundColor(Color(UIColor.systemGray))
                        .padding(.trailing, 10)
                }
            }
            else  {
                EmptyView()
            }
        }
    }
    
    var clearButtonPadding: CGFloat {
        !configuration.leftButtonConfiguration.addButton ? configuration.leftButtonConfiguration.trailingPadding : 0
    }
}

// MARK: - SecureTextInputField
struct SecureTextInputField: View {
    @Binding var text: String
    var placeholderText: String
    var configuration: TextInputFieldConfiguration
    @Binding var borderColor: Color
    
    var body: some View {
        SecureField(placeholderText, text: $text)
            .padding(configuration.general.padding)
            .background(configuration.general.backgroundColor)
            .foregroundColor(configuration.general.textColor)
            .font(configuration.general.font)
            .cornerRadius(configuration.general.cornerRadius)
            .shadow(color: configuration.general.shadowColor,
                    radius: configuration.general.shadowRadius,
                    x: configuration.general.shadowOffset.width,
                    y: configuration.general.shadowOffset.height)
            .overlay(
                RoundedRectangle(cornerRadius: configuration.general.cornerRadius)
                    .stroke(borderColor, lineWidth: configuration.general.borderWidth)
            )
            .autocapitalization(configuration.general.autocapitalization)
            .keyboardType(configuration.keyboardType)
            .padding(.horizontal, configuration.general.horizontalPadding)
            .tint(configuration.general.cursorColor)
            .submitLabel(configuration.submitLabel)
    }
}


// MARK: - RegularTextInputField
struct RegularTextInputField: View {
    @Binding var text: String
    var placeholderText: String
    var configuration: TextInputFieldConfiguration
    @Binding var borderColor: Color
    
    var body: some View {
        TextField(placeholderText, text: $text)
            .padding(configuration.general.padding)
            .background(configuration.general.backgroundColor)
            .foregroundColor(configuration.general.textColor)
            .font(configuration.general.font)
            .cornerRadius(configuration.general.cornerRadius)
            .shadow(color: configuration.general.shadowColor,
                    radius: configuration.general.shadowRadius,
                    x: configuration.general.shadowOffset.width,
                    y: configuration.general.shadowOffset.height)
            .overlay(
                RoundedRectangle(cornerRadius: configuration.general.cornerRadius)
                    .stroke(borderColor,
                            lineWidth: configuration.general.borderWidth)
            )
            .autocapitalization(configuration.general.autocapitalization)
            .keyboardType(configuration.keyboardType)
            .padding(.horizontal, configuration.general.horizontalPadding)
            .tint(configuration.general.cursorColor)
            .submitLabel(configuration.submitLabel)
    }
}

// MARK: - GeneralTextInputFieldConfiguration
struct GeneralTextInputFieldConfiguration {
    var backgroundColor: Color = .gray.opacity(0.1)
    var textColor: Color = .black
    var cursorColor: Color = .black
    var font: Font = .system(size: 16)
    var cornerRadius: CGFloat = 8
    var borderColor: Color = .blue
    var errorBorderColor: Color = .red
    var successBorderColor: Color = .gray
    var borderWidth: CGFloat = 1
    var padding: EdgeInsets = EdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8)
    var shadowColor: Color = .clear
    var shadowRadius: CGFloat = 0
    var shadowOffset: CGSize = CGSize(width: 0, height: 0)
    var autocapitalization: UITextAutocapitalizationType = .words
    var horizontalPadding: CGFloat = 0
    var verticalPadding: CGFloat = 0
}

struct ErrorMessageConfiguration {
    var font: Font = .system(size: 16, weight: .medium)
    var color: Color = .black
    var leadingPadding: CGFloat = 0
    var topPadding: CGFloat = 0
}

struct InputFieldTitleConfiguration {
    var titleFont: Font = .system(size: 16, weight: .medium)
    var titleColor: Color = .black
    var titleBottomPadding: CGFloat = 0
}

struct LeftButtonConfiguration {
    var addButton: Bool = false
    var image: Image = Image(systemName: "multiply.circle.fill")
    var trailingPadding : CGFloat = 10
    var action: (() -> Void)? = nil
}

// MARK: - TextInputFieldConfiguration
struct TextInputFieldConfiguration {
    var general: GeneralTextInputFieldConfiguration = GeneralTextInputFieldConfiguration()
    var errorMessageConfiguration: ErrorMessageConfiguration = ErrorMessageConfiguration()
    var titleConfiguration: InputFieldTitleConfiguration = InputFieldTitleConfiguration()
    var leftButtonConfiguration: LeftButtonConfiguration = LeftButtonConfiguration()
    var keyboardType: UIKeyboardType = .default
    var submitLabel: SubmitLabel = .next
   
    
    var onFocus: (() -> Void)? = nil
    var onBlur: (() -> Void)? = nil
}

// MARK: - Environment Keys
private struct TextInputFieldConfigurationKey: EnvironmentKey {
    static let defaultValue: TextInputFieldConfiguration = TextInputFieldConfiguration()
}

private struct InputFieldTitleConfigurationKey: EnvironmentKey {
    static let defaultValue: InputFieldTitleConfiguration = InputFieldTitleConfiguration()
}

extension EnvironmentValues {
    var textInputFieldConfiguration: TextInputFieldConfiguration {
        get { self[TextInputFieldConfigurationKey.self] }
        set { self[TextInputFieldConfigurationKey.self] = newValue }
    }
    
    var inputFieldTitleConfiguration: InputFieldTitleConfiguration {
        get { self[InputFieldTitleConfigurationKey.self] }
        set { self[InputFieldTitleConfigurationKey.self] = newValue }
    }
    
    var validationHandler: ((String) -> Result<Bool, ValidationError>)? {
        get { self[TextInputFieldValidationHandler.self] }
        set { self[TextInputFieldValidationHandler.self] = newValue }
    }
}

extension View {
    func textInputFieldConfiguration(_ configuration: TextInputFieldConfiguration) -> some View {
        environment(\.textInputFieldConfiguration, configuration)
    }
    
    public func onValidate(validationHandler: @escaping (String) -> Result<Bool, ValidationError>) -> some View {
        environment(\.validationHandler, validationHandler)
    }
}

// MARK: - Validation Handler
public struct ValidationError: Error {
    public init(message: String) {
        self.message = message
    }
    let message: String
}

extension ValidationError: LocalizedError {
    public var errorDescription: String? {
        return NSLocalizedString("\(message)",
                                 comment: "Message for generic validation errors.")
    }
}

private struct TextInputFieldValidationHandler: EnvironmentKey {
    static var defaultValue: ((String) -> Result<Bool, ValidationError>)?
}

// MARK: - Preview
struct TextInputField_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            TextInputField(title: "First Name",
                           text: .constant(""),
                           placeholderText: "Enter first name")
            .textInputFieldConfiguration(TextInputFieldConfiguration(
                general: GeneralTextInputFieldConfiguration(
                    backgroundColor: .white,
                    textColor: .black,
                    font: .system(size: 18, weight: .medium, design: .rounded),
                    cornerRadius: 12,
                    borderColor: .blue,
                    borderWidth: 2,
                    padding: EdgeInsets(top: 12, leading: 16, bottom: 12, trailing: 16),
                    shadowColor: .gray.opacity(0.5),
                    shadowRadius: 5,
                    shadowOffset: CGSize(width: 0, height: 2),
                    autocapitalization: .none,
                    horizontalPadding: 10,
                    verticalPadding: 10
                ),
                keyboardType: .default,
                onFocus: {
                    print("TextField focused")
                },
                onBlur: {
                    print("TextField lost focus")
                }
            ))
            
        }
        .padding()
    }
}
