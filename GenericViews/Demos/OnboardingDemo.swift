//
//  OnboardingDemo.swift
//  GenericViews
//
//  Created by Toka Elkeik on 24/06/2024.
//

import SwiftUI

struct OnboardingDemo: View {
    @State private var selectedIndex: Int = 0
    
    var data = OnboardingData(images: [Image("Group1"),
                                       Image("Group2"),
                                       Image("Group3")],
                              titles: ["Quick Appointments",
                                       "Intuitive, Simple and Friendly",
                                       "Choose the way you prefer"],
                              subtitles: ["No more calls and hectic booking processes. Book an appointment with us for seamless experience.",
                                          "Adipiscing netus semper tortor pharetra vulputate tellus. Aliquam lacus fames viverra lectus etiam non vulputate maecenas.",
                                          "With Beautisry, you’ll find tons of options to choose from according to your preference."])
    var body: some View {
        VStack {
            Onboarding(data: data,
                       selectedIndex: $selectedIndex)
            .onboardingConfiguration(OnboardingConfiguration(
                structure: .ImageTitleSubtitle,
                titleConfiguration: OnboardingTextConfiguration(font: .system(size: 26, weight: .bold), bottomPadding: 14),
                subtitleConfiguration: OnboardingTextConfiguration(font: .system(size: 14, weight: .light), bottomPadding: 8),
                imageConfiguration: OnboardingImageConfiguration(imageWidth: 300, imageHeight: 300, bottomPadding: 70)
            ))
            .padding()
            

            CustomPageControl(totalIndex: data.images.count,
                              selectedIndex: selectedIndex)
            .pageControlConfiguration(PageControlConfiguration(
                selectedColor: .black,
                unselectedColor: .gray,
                selectedSize: CGSize(width: 16, height: 10),
                unselectedSize: CGSize(width: 10, height: 10),
                cornerRadius: 10,
                animation: .spring()
            ))
        }
    }
}

#Preview {
    OnboardingDemo()
}
