//
//  Onboarding.swift
//  GenericViews
//
//  Created by Toka Elkeik on 13/06/2024.
//

import SwiftUI

// MARK: - OnboardingData
struct OnboardingData {
    var images: [Image]
    var titles: [String]?
    var subtitles: [String]?
}

// MARK: - Onboarding
struct Onboarding: View {
    var data: OnboardingData
    @Binding var selectedIndex: Int
    @Environment(\.onboardingConfiguration) var configuration: OnboardingConfiguration
    
    var body: some View {
        VStack {
            TabView(selection: $selectedIndex) {
                ForEach(0..<data.images.count, id: \.self) { index in
                    VStack(alignment: configuration.alignment, spacing: 0) {
                        switch configuration.structure {
                        case .ImageTitleSubtitle:
                            createImageView(index: index)
                            createTitleView(index: index)
                            createSubtitleView(index: index)
                            
                        case .TitleImageSubtitle:
                            createTitleView(index: index)
                            createImageView(index: index)
                            createSubtitleView(index: index)
                            
                        case .TitleSubtitleImage:
                            createTitleView(index: index)
                            createSubtitleView(index: index)
                            createImageView(index: index)
                        }
                    }
                }
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
            .animation(.easeInOut, value: selectedIndex)
        }
    }
    
    // MARK: - Helper Functions
    private func createImageView(index: Int) -> some View {
        data.images[index]
            .resizable()
            .scaledToFit()
            .frame(width: configuration.imageConfiguration.imageWidth,
                   height: configuration.imageConfiguration.imageHeight)
            .padding(.bottom, configuration.imageConfiguration.bottomPadding)
    }
    
    private func createTitleView(index: Int) -> some View {
        if let title = data.titles?[index], !title.isEmpty {
            return AnyView(Text(title)
                .font(configuration.titleConfiguration?.font)
                .foregroundColor(configuration.titleConfiguration?.color ?? .black)
                .padding(.bottom, configuration.titleConfiguration?.bottomPadding)
                .multilineTextAlignment(configuration.titleConfiguration?.textAlignment ?? .center))
        } else {
            return AnyView(EmptyView())
        }
    }
    
    private func createSubtitleView(index: Int) -> some View {
        if let subtitle = data.subtitles?[index], !subtitle.isEmpty {
            return AnyView(Text(subtitle)
                .font(configuration.subtitleConfiguration?.font)
                .foregroundColor(configuration.subtitleConfiguration?.color ?? .black)
                .padding(.bottom, configuration.subtitleConfiguration?.bottomPadding)
                .multilineTextAlignment(configuration.subtitleConfiguration?.textAlignment ?? .center))
        } else {
            return AnyView(EmptyView())
        }
    }
}


// MARK: - Configurations

enum OnboardingStructure {
    case ImageTitleSubtitle
    case TitleImageSubtitle
    case TitleSubtitleImage
}

struct OnboardingTextConfiguration {
    var font: Font = .system(size: 16, weight: .medium)
    var color: Color = .black
    var bottomPadding: CGFloat = 0
    var textAlignment: TextAlignment = .center
}

struct OnboardingImageConfiguration {
    var imageWidth: CGFloat = 200
    var imageHeight: CGFloat = 200
    var bottomPadding: CGFloat = 20
}

struct OnboardingConfiguration {
    var structure: OnboardingStructure = .ImageTitleSubtitle
    var alignment: HorizontalAlignment = .center
    var titleConfiguration: OnboardingTextConfiguration?
    var subtitleConfiguration: OnboardingTextConfiguration?
    var imageConfiguration: OnboardingImageConfiguration = OnboardingImageConfiguration()
}

// MARK: - Environment Keys
private struct OnboardingConfigurationKey: EnvironmentKey {
    static let defaultValue: OnboardingConfiguration = OnboardingConfiguration()
}

extension EnvironmentValues {
    var onboardingConfiguration: OnboardingConfiguration {
        get { self[OnboardingConfigurationKey.self] }
        set { self[OnboardingConfigurationKey.self] = newValue }
    }
}

extension View {
    func onboardingConfiguration(_ configuration: OnboardingConfiguration) -> some View {
        environment(\.onboardingConfiguration, configuration)
    }
}

 // MARK: - Preview
#Preview {
    Onboarding(data: OnboardingData(images: [Image("Group1"),
                                             Image("Group2"),
                                             Image("Group3")],
                                    titles: ["Quick Appointments",
                                             "Intuitive, Simple and Friendly",
                                             "Choose the way you prefer"],
                                    subtitles: ["No more calls and hectic booking processes. Book an appointment with us for seamless experience.",
                                                "Adipiscing netus semper tortor pharetra vulputate tellus. Aliquam lacus fames viverra lectus etiam non vulputate maecenas.",
                                                "With Beautisry, you’ll find tons of options to choose from according to your preference."]),
               selectedIndex: .constant(0))
    .onboardingConfiguration(OnboardingConfiguration(
        structure: .ImageTitleSubtitle,
        titleConfiguration: OnboardingTextConfiguration(font: .system(size: 26, weight: .bold), bottomPadding: 14),
        subtitleConfiguration: OnboardingTextConfiguration(font: .system(size: 14, weight: .light), bottomPadding: 8),
        imageConfiguration: OnboardingImageConfiguration(imageWidth: 300, imageHeight: 300, bottomPadding: 70)
    ))
    .padding()
}
