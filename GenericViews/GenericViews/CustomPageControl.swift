//
//  CustomPageControl.swift
//  GenericViews
//
//  Created by Toka Elkeik on 13/06/2024.
//

import SwiftUI

// MARK: - CustomPageControl
struct CustomPageControl: View {
    let totalIndex: Int
    var selectedIndex: Int
    @Namespace private var animation
    @Environment(\.pageControlConfiguration) var configuration: PageControlConfiguration
    
    var body: some View {
        HStack {
            ForEach(0..<totalIndex, id: \.self) { index in
                if selectedIndex == index {
                    RoundedRectangle(cornerRadius: configuration.cornerRadius)
                        .frame(width: configuration.selectedSize.width,
                               height: configuration.selectedSize.height)
                        .clipShape(RoundedRectangle(cornerRadius: configuration.cornerRadius / 2))
                        .overlay {
                            RoundedRectangle(cornerRadius: configuration.cornerRadius)
                                .fill(configuration.selectedColor)
                                .frame(width: configuration.selectedSize.width,
                                       height: configuration.selectedSize.height)
                                .matchedGeometryEffect(id: "IndicatorAnimationId", in: animation)
                        }
                } else {
                    RoundedRectangle(cornerRadius: configuration.cornerRadius)
                        .fill(configuration.unselectedColor)
                        .frame(width: configuration.unselectedSize.width,
                               height: configuration.unselectedSize.height)
                        .overlay {
                            RoundedRectangle(cornerRadius: configuration.cornerRadius)
                                .strokeBorder(configuration.unselectedStrokeColor,
                                        lineWidth: configuration.unselectedStrokeWidth)
                        }
                }
            }
        }
        .animation(configuration.animation, value: selectedIndex)
        .padding()
    }
}

struct PageControlConfiguration {
    var selectedColor: Color = .red
    var unselectedColor: Color = .green
    var selectedSize: CGSize = CGSize(width: 30, height: 7)
    var unselectedSize: CGSize = CGSize(width: 10, height: 10)
    var cornerRadius: CGFloat = 7
    var animation: Animation = .easeInOut
    var unselectedStrokeColor: Color = .clear
    var unselectedStrokeWidth: CGFloat = 1
}

private struct PageControlConfigurationKey: EnvironmentKey {
    static let defaultValue: PageControlConfiguration = PageControlConfiguration()
}

extension EnvironmentValues {
    var pageControlConfiguration: PageControlConfiguration {
        get { self[PageControlConfigurationKey.self] }
        set { self[PageControlConfigurationKey.self] = newValue }
    }
}

extension View {
    func pageControlConfiguration(_ configuration: PageControlConfiguration) -> some View {
        environment(\.pageControlConfiguration, configuration)
    }
}

#Preview {
    CustomPageControl(totalIndex: 3,
                      selectedIndex: 1)
}
